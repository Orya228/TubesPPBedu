import 'package:e_learning/ui/pages/home/home_page.dart';
import 'package:e_learning/ui/pages/profile/profile_page.dart';
import 'package:e_learning/ui/pages/schedule/schedule_page.dart';
import 'package:e_learning/ui/pages/training/training_page.dart';
import 'package:flutter/material.dart';

import 'package:e_learning/styles/text_style.dart';
import 'package:e_learning/styles/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  int _selectedIndex = 0;
  static List<Widget> pages = [
    HomePage(),
    // LoadingScreen(),
    ScheduleScreen(),
    TrainingPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: _customBottomNav(),
    );
  }

  Widget _customBottomNav() {
    return SizedBox(
      height: 75,
      child: ClipRRect(
        child: BottomNavigationBar(
          backgroundColor: kBgGray,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedLabelStyle: kButton2,
          unselectedLabelStyle: kButton2,
          selectedItemColor: kBiru,
          unselectedItemColor: kHitam,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/home.png',
                width: 30,
                height: 24,
                color: _selectedIndex == 0 ? kBiru : kHitam,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/schedule.png',
                width: 21,
                height: 24,
                color: _selectedIndex == 1 ? kBiru : kHitam,
              ),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/traning.png',
                width: 24,
                height: 24,
                color: _selectedIndex == 2 ? kBiru : kHitam,
              ),
              label: 'Training',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/profile.png',
                width: 21,
                height: 24,
                color: _selectedIndex == 3 ? kBiru : kHitam,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
