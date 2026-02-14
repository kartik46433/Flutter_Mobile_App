import 'package:flutter/material.dart';
import 'notice.dart';

class NoticeDetailPage extends StatelessWidget {
  final Notice notice;

  const NoticeDetailPage({
    super.key,
    required this.notice,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Notice Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(notice.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("${notice.teacher} • ${notice.date}",
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Text(notice.description),
          ],
        ),
      ),
    );
  }
}
