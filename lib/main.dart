import 'package:flutter/material.dart';
import 'package:mishomework/screens/examDetails.dart';
import 'package:mishomework/screens/schedulePage.dart';
import 'models/exam.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final seed = const Color(0xFF006E90);
    return MaterialApp(
      title: 'Ispiti',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.dark,
        ),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const SchedulePage(title: 'Распоред за испити - 225003'),
        "/details": (context) {
          final exam = ModalRoute.of(context)!.settings.arguments as Exam;
          return ExamDetails(exam: exam);
        },
      },
    );
  }
}
