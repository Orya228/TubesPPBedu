import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: Text(
        "Halaman Schedule",
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Color(0xff3D4DE0)),
      )),
    );
  }
}
