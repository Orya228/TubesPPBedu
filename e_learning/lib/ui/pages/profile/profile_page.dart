import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:e_learning/ui/login/login.dart';
import 'package:e_learning/ui/pages/profile/liat_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserData() async {
    return await _firestore.collection('datadiri').doc(user).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text("No data found"));
          }
          Map<String, dynamic> userData =
              snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/backgrund1.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(left: 9, right: 9, top: 230),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/icons/avatar.png',
                            width: 129,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            userData['nama'],
                            style: kTitle1,
                          ),
                          Text(
                            userData['email'],
                            style: kSubtitle1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: kPutih,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: kGray,
                                  blurRadius: 5,
                                  offset: Offset.fromDirection(2),
                                )
                              ],
                            ),
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LiatProfile(),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset(
                                          'assets/icons/editprofile.png'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Edit profile',
                                        style: kSubtitle3,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    GoogleSignIn().signOut();
                                    FirebaseAuth.instance.signOut().then(
                                        (value) => Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginScreen(),
                                            ),
                                            (route) => false));
                                  },
                                  child: Row(
                                    children: [
                                      Image.asset('assets/icons/logout.png'),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Log out',
                                        style: kSubtitle3,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
