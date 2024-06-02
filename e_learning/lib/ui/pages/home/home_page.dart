import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:e_learning/ui/pages/home/materi.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
