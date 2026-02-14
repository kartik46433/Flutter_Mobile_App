import 'package:flutter/material.dart';
import 'attendance_detail_page.dart';

class SubjectCard extends StatelessWidget {
  final String subject;
  final int attended;
  final int total;

  const SubjectCard({
    super.key,
    required this.subject,
    required this.attended,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    double percentage = (attended / total) * 100;
    bool isLow = percentage < 75;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AttendanceDetailPage(
              subject: subject,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              subject,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "$attended / $total lectures",
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: attended / total,
              minHeight: 6,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation(
                isLow ? Colors.red : Colors.green,
              ),
            ),
            const SizedBox(height: 6),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${percentage.toStringAsFixed(0)}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isLow ? Colors.red : Colors.green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
