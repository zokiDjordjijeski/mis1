import 'package:flutter/material.dart';
import 'package:mishomework/screens/examDetails.dart';

import '../models/exam.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key, required this.title});

  final String title;

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Exam> get exams => _buildExamsFromCourses(_computerEngineeringCourses);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(widget.title),
            ),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: exams.length,
                itemBuilder: (context, index) {
                  final exam = exams[index];
                  return Card(
                    color: getColor(exam),
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExamDetails(exam: exam),
                          ),
                        );
                      },
                      title: Text(
                        exam.subjectName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today, size: 16),
                              const SizedBox(width: 4),
                              Text(exam.time.toString()),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.room, size: 16),
                              const SizedBox(width: 4),
                              Text(exam.rooms.join(', ')),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                exams.length.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const List<String> _computerEngineeringCourses = [
    'Структурно програмирање',
    'Калкулус 1',
    'Калкулус 2',
    'Дискретна математика',
    'Компјутерски архитектури',
    'Веројатност и статистика',
    'Алгоритми и податочни структури',
    'Компјутерски мрежи',
    'Оперативни системи',
    'Вештачка интелигенција',
    'Теорија на информации со дигитални комуникации',
    'Софтвер за вградливи системи',
    'Дизајн на дигитални кола',
    'Физика',
    'Управување со ИКТ проекти',
    'Етичко хакирање',
    'Дизајн на компјутерски мрежи',
    'Интелигентни системи',
    'Компјутерска анимација',
    'Веб базирани системи',
    'Имплементација на системи со отворен код',
    'Виртуелизација и пресметување во облак',
  ];

  static const List<String> _roomsPool = [
    'B1', 'B2', 'B3.1', '200AB', '200V', '112', '118', '215', '223', '225', '305', '315', 'LAB-A', 'LAB-B', 'LAB-C'
  ];

  List<Exam> _buildExamsFromCourses(List<String> courses) {
    final List<Exam> exms = [];
    final DateTime base = DateTime(2026, 1, 10, 9, 0);
    final List<Duration> slots = [
      const Duration(hours: 9),
      const Duration(hours: 11),
      const Duration(hours: 5),
      const Duration(hours: 7),
      const Duration(hours: 1),
      const Duration(hours: 3),
    ];

    for (int i = 0; i < courses.length; i++) {
      String name = courses[i];
      DateTime day = base.add(Duration(days: i));
      if (day.weekday == DateTime.saturday) {
        day = day.add(const Duration(days: 2));
      } else if (day.weekday == DateTime.sunday) {
        day = day.add(const Duration(days: 1));
      }
      final DateTime time = DateTime(day.year, day.month, day.day, 9, 0).add(slots[i % slots.length]);
      final String r1 = _roomsPool[i % _roomsPool.length];
      final String r2 = _roomsPool[(i + 3) % _roomsPool.length];
      final List<String> rooms = r1 == r2 ? [r1] : [r1, r2];

      exms.add(Exam(
        subjectName: name,
        time: time,
        rooms: rooms,
      ));
    }

    exms.sort((a, b) => a.time.compareTo(b.time));
    return exms;
  }

  Color getColor(Exam exam) {
    final DateTime now = DateTime.now();
    return exam.time.isBefore(now) ? Colors.red : Colors.green;
  }
}
