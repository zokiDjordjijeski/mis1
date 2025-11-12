import 'package:flutter/material.dart';
import 'package:mishomework/models/exam.dart';

class ExamDetails extends StatefulWidget {
  const ExamDetails({super.key, required this.exam});

  final Exam exam;

  @override
  State<ExamDetails> createState() => _ExamDetailsState();
}

class _ExamDetailsState extends State<ExamDetails> {
  static const List<String> _mkWeekdays = [
    'Понеделник',
    'Вторник',
    'Среда',
    'Четврток',
    'Петок',
    'Сабота',
    'Недела',
  ];

  String _two(int n) => n.toString().padLeft(2, '0');

  String _mkPlural(int value, String one, String few, String many) {
    final v = value.abs();
    final mod10 = v % 10;
    final mod100 = v % 100;
    if (v == 1) return one;
    if (mod10 >= 2 && mod10 <= 4 && !(mod100 >= 12 && mod100 <= 14)) return few;
    return many;
  }

  String _formatDate(DateTime dt) {
    final weekday = _mkWeekdays[(dt.weekday + 5) % 7];
    return '$weekday, ${dt.day}.${dt.month}.${dt.year}';
  }

  String _formatTime(DateTime dt) => '${_two(dt.hour)}:${_two(dt.minute)}';

  String _formatCountdown(Duration d) {
    final neg = d.isNegative;
    final dur = neg ? d.abs() : d;
    final days = dur.inDays;
    final hours = dur.inHours % 24;
    final mins = dur.inMinutes % 60;
    final dayUnit = _mkPlural(days, 'ден', 'дена', 'дена');
    final hourUnit = _mkPlural(hours, 'час', 'часа', 'часа');
    final minUnit = _mkPlural(mins, 'минута', 'минути', 'минути');
    if (days > 0) {
      return neg
          ? 'Пред $days $dayUnit'
          : '$days $dayUnit, $hours $hourUnit, $mins $minUnit';
    }
    if (hours > 0) {
      return neg ? 'Пред $hours $hourUnit' : '$hours $hourUnit, $mins $minUnit';
    }
    if (mins > 0) {
      return neg ? 'Пред $mins $minUnit' : '$mins $minUnit';
    }
    return neg ? 'Пред помалку од минута' : 'Помалку од минута';
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final diff = widget.exam.time.difference(now);
    final isPassed = diff.isNegative;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.exam.subjectName),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.exam.subjectName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    const Text(
                      'Ден и време',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatDate(widget.exam.time),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatTime(widget.exam.time),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    const Text(
                      'Училница',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.exam.rooms.join(', '),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),
                    Text(
                      isPassed ? 'Испитот поминал' : 'Време до испитот',
                      style: TextStyle(
                        fontSize: 14,
                        color: isPassed ? Colors.red : Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _formatCountdown(diff),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isPassed ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
