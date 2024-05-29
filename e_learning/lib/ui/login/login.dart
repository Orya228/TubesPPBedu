import 'package:e_learning/ui/pages/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:e_learning/bloc/login/login_cubit.dart';

import '../../utils/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailEdc = TextEditingController();
  final passEdc = TextEditingController();
  bool passInvisible = false;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential).then(
        (value) async => await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (route) => false));
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
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.green,
              ));
            Navigator.pushNamedAndRemoveUntil(context, rHome, (route) => false);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: ListView(
            children: [
              const SafeArea(
                child: Image(
                  image: AssetImage('assets/icons/logo.png'),
                ),
              ),
              const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Selamat Datang",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff000000),
                      ),
                    ),
                    SizedBox(
                      width: 230,
                      child: Text(
                        "Mari bantu siswa menjadi lebih pintar dengan belajar bersama kami.",
                        style: TextStyle(
                          fontSize: 10,
                          color: Color(0xffB5B5B5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Email",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 310,
                height: 35,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xff000000).withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                    ),
                    controller: emailEdc,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Password",
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 310,
                height: 35,
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xff000000).withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: TextFormField(
                    controller: passEdc,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 13),
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
                      backgroundColor: Color(0xff4067CB),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.white),
                  )),
              const SizedBox(
                height: 9.0,
              ),
              Column(
                children: [
                  const Text(
                    'atau lanjut dengan',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
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
                      const Text(
                        "Belum punya akun?",
                        style: TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 12),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          "Register",
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Color(0xff0961F5)),
                        ),
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
