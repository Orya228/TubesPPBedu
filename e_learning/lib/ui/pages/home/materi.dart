import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:flutter/material.dart';

class Materi extends StatelessWidget {
  final String? kelas;
  const Materi({Key? key, this.kelas}) : super(key: key);
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
              _listMateri('Bahasa Indonesia', 'indonesia.png'),
              _listMateri('Matematika', 'matematika.png'),
              _listMateri('Ilmu Pengetahuan Alam (IPA)', 'ipa.png'),
              _listMateri('Ilmu Pengetahuan Sosial (IPS)', 'ips.png'),
              _listMateri('Pendidikan Kewarganegaraan', 'pkn.png'),
              _listMateri('Pendidikan Agama Islam', 'agama.png'),
              _listMateri('Seni Budaya', 'seni_budaya.png'),
              _listMateri('PJOK', 'pjok.png'),
              _listMateri('Bahasa Inggris', 'english.png'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _listMateri(String nama, String gambar) {
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
                  '$nama',
                  style: kTitle3,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Image.asset('assets/sampul/${gambar}'),
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
                        onPressed: () {},
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: kPutih,
                            side: BorderSide(color: kBiru),
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
