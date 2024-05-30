import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
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
            Text(
              "Let’s Get Started",
              style: kHeading5.copyWith(color: kHitam),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 237,
              ),
              child: Text(
                "Hello, Edupedia users! Let's start the learning journey with this app.",
                textAlign: TextAlign.center,
                style: kSubtitle2.copyWith(color: kGray),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kBiru,
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
              child: Text(
                'Start',
                style: kButton1.copyWith(color: kPutih),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
