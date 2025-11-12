import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  final VoidCallback onTap;

  const ExamCard({
    super.key,
    required this.exam,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      color: exam.isPast ? Colors.grey[300] : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subject Name
              Text(
                exam.subjectName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: exam.isPast ? Colors.grey[600] : Colors.blue[800],
                ),
              ),
              const SizedBox(height: 12),
              
              // Date and Time with icon
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 18,
                    color: exam.isPast ? Colors.grey : Colors.blue,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${exam.dateTime.day}/${exam.dateTime.month}/${exam.dateTime.year} at ${exam.dateTime.hour.toString().padLeft(2, '0')}:${exam.dateTime.minute.toString().padLeft(2, '0')}",
                    style: TextStyle(
                      fontSize: 16,
                      color: exam.isPast ? Colors.grey : Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Venue with icon
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: exam.isPast ? Colors.grey : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      exam.venues.join(", "),
                      style: TextStyle(
                        fontSize: 16,
                        color: exam.isPast ? Colors.grey : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              
              // Status badge
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: exam.isPast ? Colors.grey : Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  exam.isPast ? "ПОМИНАТ" : "СЛЕДЕН",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}