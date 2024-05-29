import 'package:e_learning/bloc/register/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailEdc = TextEditingController();
  final passEdc = TextEditingController();
  bool passInvisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text('Loading..')));
          }
          if (state is RegisterFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.red,
              ));
          }
          if (state is RegisterSuccess) {
            // context.read<AuthCubit>().loggedIn();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(state.msg),
                backgroundColor: Colors.green,
              ));
            Navigator.pushNamedAndRemoveUntil(
                context, rLogin, (route) => false);
          }
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 70),
          child: ListView(
            children: [
              const Center(
                child: Text(
                  "Registrasi",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff000000)),
                ),
              ),
              const SizedBox(
                height: 65,
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
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<RegisterCubit>()
                        .register(email: emailEdc.text, password: passEdc.text);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff4067CB),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: const Text(
                    "Registrasi",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.white),
                  )),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sudah punya akun ?",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            color: Color(0xff0961F5)),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
