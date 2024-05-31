import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:e_learning/ui/pages/content/pdf_viewer.dart';
import 'package:flutter/material.dart';

class Quizz extends StatelessWidget {
  final String? kelas;
  final String? lib1;
  String getDirectory(String kelas, String buku) {
    return 'assets/buku/Quiz-kelas_1-agama.pdf';
  }

  const Quizz({super.key, this.kelas, this.lib1});

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
              _listQuizz(context, 'Bahasa Indonesia', 'indonesia', '$lib1'),
              _listQuizz(context, 'Matematika', 'matematika', '$lib1'),
              _listQuizz(
                  context, 'Ilmu Pengetahuan Alam (IPA)', 'ipa', '$lib1'),
              _listQuizz(
                  context, 'Ilmu Pengetahuan Sosial (IPS)', 'ips', '$lib1'),
              _listQuizz(context, 'Pendidikan Kewarganegaraan', 'pkn', '$lib1'),
              _listQuizz(context, 'Pendidikan Agama Islam', 'agama', '$lib1'),
              _listQuizz(context, 'Seni Budaya', 'seni_budaya', '$lib1'),
              _listQuizz(context, 'PJOK', 'pjok', '$lib1'),
              _listQuizz(context, 'Bahasa Inggris', 'english', '$lib1'),
            ],
          ),
        ),
      ),
    );
  }

  Padding _listQuizz(
      BuildContext context, String nama, String gambar, String lib1) {
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
              SizedBox(
                width: 284,
                height: 35,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MyPdfViewer(judul: nama, dir: directory),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPutih,
                        side: BorderSide(color: kBiru),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    child: Text(
                      "Kerjakan Quizz",
                      style: kButton1.copyWith(color: kBiru),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
