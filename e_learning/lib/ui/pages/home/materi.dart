import 'dart:ffi';

import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:e_learning/ui/pages/content/pdf_viewer.dart';
import 'package:e_learning/ui/pages/content/yt_viewer.dart';
import 'package:flutter/material.dart';

class Materi extends StatelessWidget {
  final String? kelas;
  final String? lib1;

  String getDirectory(String kelas, String buku) {
    return 'assets/buku/$kelas-$buku.pdf';
  }

  const Materi({Key? key, this.kelas, this.lib1}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "$kelas",
          style: kTitle2,
        ),
        centerTitle: true,
        backgroundColor: kPutih,
        leading: GestureDetector(
          child: Image.asset('assets/icons/backbutton.png'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              _listMateri(
                  context, 'Bahasa Indonesia', 'indonesia', '$lib1', false),
              _listMateri(context, 'Matematika', 'matematika', '$lib1', false),
              _listMateri(context, 'Ilmu Pengetahuan Alam (IPA)', 'ipa',
                  '$lib1', false),
              _listMateri(context, 'Ilmu Pengetahuan Sosial (IPS)', 'ips',
                  '$lib1', false),
              _listMateri(
                  context, 'Pendidikan Kewarganegaraan', 'pkn', '$lib1', false),
              _listMateri(
                  context, 'Pendidikan Agama Islam', 'agama', '$lib1', false),
              _listMateri(
                  context, 'Seni Budaya', 'seni_budaya', '$lib1', false),
              _listMateri(context, 'PJOK', 'pjok', '$lib1', false),
              _listMateri(context, 'Bahasa Inggris', 'english', '$lib1', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listMateri(BuildContext context, String nama, String gambar,
      String lib1, bool open) {
    String directory = getDirectory(lib1, gambar);
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Card(
        color: kPutih,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  nama,
                  style: kTitle3,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/sampul/$gambar.png'),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 137,
                    height: 35,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyPdfViewer(
                                judul: nama,
                                dir: directory,
                                open: open,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kBiru,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        child: Text(
                          "Liat Buku",
                          style: kButton1.copyWith(color: kPutih),
                        )),
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 137,
                    height: 35,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => YoutubePlayerExample(
                                kelas: kelas,
                                Materi: nama,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPutih,
                            side: const BorderSide(color: kBiru),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5))),
                        child: Text(
                          "Liat Video",
                          style: kButton1.copyWith(color: kBiru),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
