import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:e_learning/ui/pages/home_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfile();
}

class _EditProfile extends State<EditProfile> {
  final user = FirebaseAuth.instance.currentUser?.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _namaController = TextEditingController();
  String? _kelasController;
  final TextEditingController _tanggalLahirController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (user != null) {
      getUserData();
    }
  }

  Future<void> getUserData() async {
    DocumentSnapshot userDoc =
        await _firestore.collection('datadiri').doc(user).get();
    Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
    _namaController.text = data['nama'];
    _kelasController = data['kelas'].toString();
    _tanggalLahirController.text = data['tanggal_lahir'];
    setState(() {});
  }

  Future<void> _saveUserData() async {
    if (_formKey.currentState?.validate() ?? false) {
      await _firestore.collection('datadiri').doc(user).update({
        'nama': _namaController.text,
        'kelas': int.parse(_kelasController!),
        'tanggal_lahir': _tanggalLahirController.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil Diubah')),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Edit Profile",
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
      body: Form(
        key: _formKey,
        child: Column(
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
                    padding: const EdgeInsets.only(left: 9, right: 9, top: 80),
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
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nama",
                                  style: kHeading6.copyWith(color: kHitam)),
                              const SizedBox(height: 5),
                              TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kHitam),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kHitam),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  contentPadding: EdgeInsets.all(12),
                                ),
                                controller: _namaController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Nama tidak boleh kosong';
                                  }
                                  print('isi data $value');
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              Text("Kelas",
                                  style: kHeading6.copyWith(color: kHitam)),
                              const SizedBox(height: 5),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kHitam),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kHitam),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  contentPadding: EdgeInsets.all(12),
                                ),
                                value: _kelasController,
                                items: ['1', '2', '3', '4', '5', '6']
                                    .map((label) => DropdownMenuItem(
                                          child: Text(
                                            label,
                                            style: kHeading6.copyWith(
                                                color: kHitam),
                                          ),
                                          value: label,
                                        ))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _kelasController = value;
                                  });
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return 'Pilih Kelas';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 20),
                              Text("Tanggal Lahir (DD/MM/YYYY)",
                                  style: kHeading6.copyWith(color: kHitam)),
                              const SizedBox(height: 5),
                              TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kHitam),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kHitam),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  contentPadding: EdgeInsets.all(12),
                                ),
                                controller: _tanggalLahirController,
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Tanggal lahir tidak boleh kosong';
                                  } else if (!RegExp(
                                          r'^([0-2][0-9]|(3)[0-1])\/((0)[0-9]|(1)[0-2])\/((19|20)\d\d)$')
                                      .hasMatch(value)) {
                                    return 'Masukkan tanggal lahir yang valid (DD/MM/YYYY)';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
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
                  backgroundColor: kPutih,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(color: kBiru)),
                ),
                onPressed: _saveUserData,
                child: Text(
                  'Simpan Profile',
                  style: kButton1.copyWith(color: kBiru),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
