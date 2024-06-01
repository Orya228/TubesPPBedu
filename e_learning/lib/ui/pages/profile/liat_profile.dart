import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LiatProfile extends StatefulWidget {
  const LiatProfile({super.key});

  @override
  State<LiatProfile> createState() => _LiatProfile();
}

class _LiatProfile extends State<LiatProfile> {
  final user = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentSnapshot> getUserData() async {
    return await _firestore.collection('datadiri').doc(user).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: kTitle2.copyWith(color: kPutih),
        ),
        centerTitle: true,
        backgroundColor: kBiruTua,
        leading: GestureDetector(
          child: Image.asset(
            'assets/icons/backbutton.png',
            color: kPutih,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
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
                    height: 220,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/icons/backgrund1.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.only(left: 9, right: 9, top: 80),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/icons/avatar.png',
                            width: 129,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Column(
                                children: [
                                  _listData(userData['nama'], 'Name'),
                                  _listData(
                                      userData['kelas'].toString(), 'Kelas'),
                                  _listData(userData['tanggal_lahir'],
                                      'Tanggal Lahir'),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: Container()),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBiru,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Edit Profile',
                    style: kButton1.copyWith(color: kPutih),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Padding _listData(String userData, String judul) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            judul,
            style: kSubtitle5,
          ),
          const SizedBox(height: 11),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: kLightGray,
              border: Border.all(color: kGray.withOpacity(0.5)),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(userData),
          )
        ],
      ),
    );
  }
}
