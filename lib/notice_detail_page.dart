import 'package:flutter/material.dart';
import 'notice.dart'; // Import the model

class NoticeDetailPage extends StatelessWidget {
  final Notice notice;

  const NoticeDetailPage({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text("Details", style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notice.title,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.person_outline, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(notice.teacher,
                    style: const TextStyle(color: Colors.grey)),
                const SizedBox(width: 15),
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(notice.date, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const Divider(height: 40),
            Text(
              notice.description,
              style: const TextStyle(
                  fontSize: 16, height: 1.5, color: Colors.black87),
            ),
            const SizedBox(height: 30),
            if (notice.attachment != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue.withOpacity(0.1)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.file_present, color: Colors.blue),
                    const SizedBox(width: 10),
                    Text(notice.attachment!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    const Icon(Icons.download, color: Colors.blue),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
