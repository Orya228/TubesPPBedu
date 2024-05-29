import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SafeArea(
              child: Image(
                image: AssetImage('assets/icons/logo.png'),
              ),
            ),
            const Text(
              "Let’s Get Started",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff000000),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 237,
              ),
              child: const Text(
                "Hello, Edupedia users! Let's start the learning journey with this app.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  color: Color(0xffB5B5B5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff3D4DE0),
                padding: const EdgeInsets.symmetric(
                  vertical: 9,
                  horizontal: 140,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              child: const Text(
                'Start',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
