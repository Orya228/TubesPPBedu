import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:e_learning/ui/pages/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Filldatascreen extends StatefulWidget {
  const Filldatascreen({Key? key}) : super(key: key);

  @override
  State<Filldatascreen> createState() => _Filldatascreen();
}

class _Filldatascreen extends State<Filldatascreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController kelasController = TextEditingController();
  final TextEditingController tanggalController = TextEditingController();
  String? _kelas;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          padding: const EdgeInsets.only(top: 100),
          children: [
            Text(
              "Personal Data",
              style: kTitle2.copyWith(color: kHitam),
            ),
            Text(
              "Fill in your personal data to start the journey",
              style: kSubtitle1.copyWith(color: kPutihGelap),
            ),
            Center(
              child: Image.asset('assets/icons/image1.png'),
            ),
            const SizedBox(
              height: 65,
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nama", style: kHeading6.copyWith(color: kHitam)),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kHitam),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kHitam),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    controller: namaController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Text("Kelas", style: kHeading6.copyWith(color: kHitam)),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kHitam),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kHitam),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    value: _kelas,
                    items: ['1', '2', '3', '4', '5', '6']
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(
                                label,
                                style: kHeading6.copyWith(color: kHitam),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _kelas = value;
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
                        borderSide: const BorderSide(color: kHitam),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: kHitam),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: const EdgeInsets.all(12),
                    ),
                    controller: tanggalController,
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
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await _firestore
                                .collection('datadiri')
                                .doc(user!.uid)
                                .set({
                              'userID': user?.uid,
                              'nama': namaController.text,
                              'email': user?.email,
                              'kelas': int.parse(_kelas!),
                              'tanggal_lahir': tanggalController.text,
                              'timestamp': FieldValue.serverTimestamp(),
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Data berhasil disimpan')),
                            );
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (route) => false,
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$e')),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kBiru,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: Text(
                        'Simpan Data',
                        style: kButton1.copyWith(color: kPutih),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
