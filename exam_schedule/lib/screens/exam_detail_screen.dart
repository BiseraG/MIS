import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({
    super.key,
    required this.exam,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exam.subjectName),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Subject Name
                Center(
                  child: Text(
                    exam.subjectName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Date and Time
                _buildDetailRow(
                  icon: Icons.calendar_today,
                  iconColor: Colors.blue,
                  title: "Датум и време",
                  value: "${exam.dateTime.day}/${exam.dateTime.month}/${exam.dateTime.year} at ${exam.dateTime.hour.toString().padLeft(2, '0')}:${exam.dateTime.minute.toString().padLeft(2, '0')}",
                ),
                const SizedBox(height: 20),
                
                // Venue(s)
                _buildDetailRow(
                  icon: Icons.location_on,
                  iconColor: Colors.red,
                  title: "Простории",
                  value: exam.venues.join("\n"),
                  isMultiLine: true,
                ),
                const SizedBox(height: 20),
                
                // Time Left
                _buildDetailRow(
                  icon: Icons.access_time,
                  iconColor: exam.isPast ? Colors.grey : Colors.green,
                  title: "Time Left",
                  value: exam.timeLeft,
                ),
                const SizedBox(height: 40),
                
                // Status Card
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: exam.isPast ? Colors.grey : Colors.green,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      exam.isPast ? "ИСПИТОТ ПОМИНА" : "СЛЕДЕН ИСПИТ",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
    bool isMultiLine = false,
  }) {
    return Row(
      crossAxisAlignment: isMultiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 24, color: iconColor),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              isMultiLine
                  ? Text(
                      value,
                      style: const TextStyle(fontSize: 18),
                    )
                  : Text(
                      value,
                      style: const TextStyle(fontSize: 18),
                    ),
            ],
          ),
        ),
      ],
    );
  }
}