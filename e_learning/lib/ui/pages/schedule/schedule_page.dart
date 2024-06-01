import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: ListView(
        children: [
          ScheduleItem(className: 'Kelas 1', context: context),
          ScheduleItem(className: 'Kelas 2', context: context),
          ScheduleItem(className: 'Kelas 3', context: context),
          ScheduleItem(className: 'Kelas 4', context: context),
          ScheduleItem(className: 'Kelas 5', context: context),
          ScheduleItem(className: 'Kelas 6', context: context),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule), label: 'Schedule'),
          BottomNavigationBarItem(
              icon: Icon(Icons.fitness_center), label: 'Training'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 1,
        selectedItemColor: Colors.blue,
      ),
    );
  }
}

class ScheduleItem extends StatelessWidget {
  final String className;
  final BuildContext context;

  ScheduleItem({required this.className, required this.context});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(className),
      leading: Icon(Icons.house),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ClassScheduleScreen(className: className)),
        );
      },
    );
  }
}

class ClassScheduleScreen extends StatelessWidget {
  final String className;

  ClassScheduleScreen({required this.className});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule - $className'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          ScheduleDetail(day: 'Monday', subjects: [
            {'time': '06.45 - 07.00', 'subject': 'Upacara'},
            {'time': '07.00 - 07.35', 'subject': 'Bahasa Indonesia'},
            {'time': '07.35 - 08.10', 'subject': 'Istirahat'},
            {'time': '08.10 - 09.35', 'subject': 'IPS'},
            {'time': '09.35 - 10.45', 'subject': 'Seni Budaya'},
          ]),
          ScheduleDetail(day: 'Tuesday', subjects: [
            {'time': '06.45 - 07.00', 'subject': 'Literasi'},
            {'time': '07.00 - 08.10', 'subject': 'Pendidikan Agama Islam'},
            {'time': '08.10 - 09.35', 'subject': 'Matematika'},
            {'time': '09.35 - 10.45', 'subject': 'IPA'},
          ]),
          ScheduleDetail(day: 'Wednesday', subjects: [
            {'time': '06.45 - 07.00', 'subject': 'Literasi'},
            {'time': '07.00 - 07.35', 'subject': 'Matematika'},
            {'time': '07.35 - 08.10', 'subject': 'Bahasa Indonesia'},
            {'time': '08.10 - 09.35', 'subject': 'Istirahat'},
            {'time': '09.20 - 09.45', 'subject': 'Bahasa Inggris'},
          ]),
        ],
      ),
    );
  }
}

class ScheduleDetail extends StatelessWidget {
  final String day;
  final List<Map<String, String>> subjects;

  ScheduleDetail({required this.day, required this.subjects});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...subjects.map((subject) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(subject['time']!, style: TextStyle(fontSize: 16)),
                    Text(subject['subject']!, style: TextStyle(fontSize: 16)),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
