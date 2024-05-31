import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:e_learning/ui/pages/training/quizz.dart';
import 'package:flutter/material.dart';

class TrainingPage extends StatelessWidget {
  const TrainingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quizz',
          style: kTitle2,
        ),
        centerTitle: true,
        backgroundColor: kPutih,
      ),
      body: Container(
        color: kPutih,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _listKelasQuis(context, 'Kelas 1', 'kelas_1'),
            _listKelasQuis(context, 'Kelas 2', 'kelas_2'),
            _listKelasQuis(context, 'Kelas 3', 'kelas_3'),
            _listKelasQuis(context, 'Kelas 4', 'kelas_4'),
            _listKelasQuis(context, 'Kelas 5', 'kelas_5'),
            _listKelasQuis(context, 'Kelas 6', 'kelas_6'),
          ],
        ),
      ),
    );
  }

  Widget _listKelasQuis(BuildContext context, String kelas, String lib1) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Card(
        color: kPutih,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: double.infinity,
          // width: 310,
          height: 65,
          padding: const EdgeInsets.only(left: 29, right: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  width: 25,
                  height: 22,
                  child: Image.asset('assets/icons/kelas.png')),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  kelas,
                  style: kButton2,
                ),
              ),
              GestureDetector(
                child: Image.asset('assets/icons/nextbutton.png'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Quizz(kelas: kelas, lib1: lib1),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
