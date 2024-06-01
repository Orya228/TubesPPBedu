import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:e_learning/ui/login/login.dart';
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
          // return Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text("Nama: ${userData['nama']}",
          //           style: TextStyle(fontSize: 18)),
          //       Text("Email: ${userData['email']}",
          //           style: TextStyle(fontSize: 18)),
          //       Text("Gender: ${userData['gender']}",
          //           style: TextStyle(fontSize: 18)),
          //       Text("Kelas: ${userData['kelas']}",
          //           style: TextStyle(fontSize: 18)),
          //       Text("Tanggal Lahir: ${userData['tanggal_lahir']}",
          //           style: TextStyle(fontSize: 18)),
          //     ],
          //   ),
          // );
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 102),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "MY PROFILE",
                  style: kHeading4,
                ),
                const SizedBox(
                  height: 65,
                ),
                Image.asset('assets/icons/avatar.png'),
                const SizedBox(
                  height: 12,
                ),
                _datadiri('Nama', userData['nama']),
                _datadiri('Email', userData['email']),
                _datadiri('Genader', userData['gender']),
                _datadiri('Kelas', userData['kelas']),
                _datadiri('Tanggal Lahir', userData['tanggal_lahir']),
                SizedBox(
                  height: 80,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      GoogleSignIn().signOut();
                      FirebaseAuth.instance
                          .signOut()
                          .then((value) => Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (route) => false));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPutih,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        side: BorderSide(color: kBiru)),
                    child: Text(
                      'Logout',
                      style: kSubtitle1,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Row _datadiri(String judul, dynamic isi) {
    return Row(
      children: [
        Container(
          width: 100,
          child: Text(
            judul,
            style: kSubtitle1.copyWith(color: kGray),
          ),
        ),
        Expanded(
          child: Text(
            ": $isi",
            style: kSubtitle4,
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }
}
