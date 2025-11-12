import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../widgets/exam_card.dart';
import 'exam_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Exam> exams = [
    Exam(
      subjectName: "Бази на податоци",
      dateTime: DateTime(2025, 11, 9, 9, 0),
      venues: ["лаб. 138", "лаб. 215", "лаб. 200а"],
    ),
    Exam(
      subjectName: "Имплементација на софтверски системи со слободен и отворен код",
      dateTime: DateTime(2025, 11, 5, 14, 0),
      venues: ["лаб. 2", "лаб. 3"],
    ),
    Exam(
      subjectName: "Бизнис и менаџмент",
      dateTime: DateTime(2025, 11, 7, 10, 30),
      venues: ["лаб. 138", "лаб. 215"],
    ),
    Exam(
      subjectName: "Веројатност и статистика",
      dateTime: DateTime(2025, 11, 22, 9, 0),
      venues: ["АМФ ФИНКИ Г", "Електро/ Машински", "Б1"],
    ),
    Exam(
      subjectName: "Напреден веб дизајн ",
      dateTime: DateTime(2025, 11, 25, 13, 0),
      venues: ["117", "315"],
    ),
    Exam(
      subjectName: "Алгоритми и податочни структури",
      dateTime: DateTime(2025, 11, 11, 11, 0),
      venues: ["лаб. 138", "лаб. 215", "лаб. 200а"],
    ),
    Exam(
      subjectName: "Компјутерски мрежи и безбедност ",
      dateTime: DateTime(2025, 11, 27, 15, 0),
      venues: ["лаб. 2", "лаб. 3"],
    ),
    Exam(
      subjectName: "Вовед во науката за податоци",
      dateTime: DateTime(2025, 11, 2, 10, 0),
      venues: ["лаб. 138", "лаб. 215"],
    ),
    Exam(
      subjectName: "Структурно програмирање",
      dateTime: DateTime(2025, 11, 29, 14, 30),
      venues: ["117", "315","200ц"],
    ),
    Exam(
      subjectName: "Линеарна алгебра и примени",
      dateTime: DateTime(2025, 11, 14, 14, 30),
      venues: ["Б3.2", "Б2.2"],
    ),
    Exam(
      subjectName: "Мобилни платформи и програмирање",
      dateTime: DateTime(2025, 11, 8, 9, 30),
      venues: ["АМФ ФИНКИ Г", "Електро/ Машински", "Б1"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Sort exams chronologically
    exams.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    
    return Scaffold(
      appBar: AppBar(
        title: const Text("Распоред за испити - 211023"),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: exams.length,
              itemBuilder: (context, index) {
                return ExamCard(
                  exam: exams[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExamDetailScreen(exam: exams[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // Badge showing total number of exams
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              border: Border.all(color: Colors.blue),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.school, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  "Вкупно испити: ${exams.length} :)",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}