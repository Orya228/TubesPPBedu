import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:e_learning/ui/pages/content/pdf_viewer.dart';
import 'package:e_learning/ui/pages/home/materi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final user = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(top: 40),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello, Student',
              style: kTitle1.copyWith(color: kHitam),
            ),
            Text(
              'Let’s learn something today',
              style: kSubtitle3.copyWith(color: kDarkGray.withOpacity(0.8)),
            ),
            const SizedBox(
              height: 21,
            ),
            Text(
              'Class',
              style: kTitle2.copyWith(color: kHitam),
            ),
            const SizedBox(
              height: 11,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    shrinkWrap: true,
                    children: [
                      _cardKelas(context, 'Kelas 1', 'kelas_1'),
                      _cardKelas(context, 'Kelas 2', 'kelas_2'),
                      _cardKelas(context, 'Kelas 3', 'kelas_3'),
                      _cardKelas(context, 'Kelas 4', 'kelas_4'),
                      _cardKelas(context, 'Kelas 5', 'kelas_5'),
                      _cardKelas(context, 'Kelas 6', 'kelas_6'),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              'Continue Learning',
              style: kTitle2.copyWith(color: kHitam),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('pdf_views')
                    .where('user', isEqualTo: user)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No data available'));
                  }

                  final pdfViews = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: pdfViews.length,
                    itemBuilder: (context, index) {
                      final pdfView = pdfViews[index];
                      final sampul = pdfView['sampul'] ?? '';
                      final jenis = pdfView['jenis'] ?? '';
                      final judul = pdfView['judul'] ?? '';
                      final directory = pdfView['directory'] ?? '';
                      final pageNumber = pdfView['page_number'] ?? '';
                      final docId = pdfView.id;

                      return Card(
                        color: kPutih,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: kBgGray)),
                        child: Stack(
                          children: [
                            ListTile(
                              leading: Image.asset(sampul,
                                  width: 50, height: 50, fit: BoxFit.cover),
                              title: Text(jenis,
                                  style: kTitle2.copyWith(color: kHitam)),
                              subtitle: Text(judul,
                                  style: kSubtitle3.copyWith(
                                      color: kDarkGray.withOpacity(0.8))),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyPdfViewer(
                                      judul: judul,
                                      dir: directory,
                                      open: true,
                                      sampul: sampul,
                                      jenis: jenis,
                                      buku: judul,
                                      halaman: pageNumber,
                                      docId: docId,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: Image.asset('assets/icons/close.png',
                                    width: 24, height: 24),
                                onPressed: () async {
                                  await FirebaseFirestore.instance
                                      .collection('pdf_views')
                                      .doc(docId)
                                      .delete();
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell _cardKelas(
    BuildContext context,
    String kelas,
    String lib1,
  ) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Materi(kelas: kelas, lib1: lib1)),
        );
      },
      child: Card(
        color: kPutih,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/icons/kelas.png'),
            Text(
              '($kelas)',
              style: kButton2,
            )
          ],
        ),
      ),
    );
  }
}
