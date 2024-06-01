import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:e_learning/bloc/login/login_cubit.dart';
import 'package:e_learning/utils/NavigationService.dart';

// import '../../utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailEdc = TextEditingController();
  final passEdc = TextEditingController();
  final NavigationService _navigationService = NavigationService();
  bool passInvisible = false;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? user = userCredential.user;

    if (user != null) {
      await _navigationService.checkUserDataAndNavigate(context, user);
    }
    return userCredential;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('Loading..')));
          }
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.red,
              ));
          }
          if (state is LoginSuccess) {
            // context.read<AuthCubit>().loggedIn();
            User user = state.user;
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.green,
              ));
            _navigationService.checkUserDataAndNavigate(context, user);
            // Navigator.pushNamedAndRemoveUntil(context, rHome, (route) => false);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            padding: EdgeInsets.only(top: 100),
            children: [
              const SafeArea(
                child: Image(
                  image: AssetImage('assets/icons/logo.png'),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Selamat Datang",
                      style: kHeading5.copyWith(color: kHitam),
                    ),
                    SizedBox(
                      width: 230,
                      child: Text(
                        "Mari bantu siswa menjadi lebih pintar dengan belajar bersama kami.",
                        style: kSubtitle2.copyWith(color: kGray),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Email",
                style: kHeading6.copyWith(color: kHitam),
              ),
              Container(
                width: 310,
                height: 35,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: kHitam.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12)),
                    controller: emailEdc,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Password",
                style: kHeading6.copyWith(color: kHitam),
              ),
              Container(
                width: 310,
                height: 35,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: kHitam.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: TextFormField(
                    controller: passEdc,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          passInvisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            passInvisible = !passInvisible;
                          });
                        },
                      ),
                    ),
                    obscureText: !passInvisible,
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<LoginCubit>()
                        .login(email: emailEdc.text, password: passEdc.text);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: kBiru,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: Text(
                    "Login",
                    style: kButton1.copyWith(color: kPutih),
                  )),
              const SizedBox(
                height: 9.0,
              ),
              Column(
                children: [
                  Text(
                    'atau lanjut dengan',
                    style: kSubtitle1.copyWith(color: kHitam),
                  ),
                  const SizedBox(height: 9),
                  GestureDetector(
                    onTap: () {
                      signInWithGoogle();
                    },
                    child: const CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage('assets/icons/google.png'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Belum punya akun?",
                        style: kSubtitle1.copyWith(color: kHitam),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text("Register",
                            style: kSubtitle1.copyWith(color: kBiruMuda)),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
