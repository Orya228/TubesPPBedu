import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/ui/login/fill_data.dart';
import 'package:e_learning/ui/pages/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> checkUserDataAndNavigate(BuildContext context, User user) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('datadiri').doc(user.uid).get();

    if (userDoc.exists) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Filldatascreen()),
        (route) => false,
      );
    }
  }
}
