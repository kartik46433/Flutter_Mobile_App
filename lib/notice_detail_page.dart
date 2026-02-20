import 'package:flutter/material.dart';
import 'notice.dart'; // Import the model

class NoticeDetailPage extends StatelessWidget {
  final Notice notice;

  const NoticeDetailPage({super.key, required this.notice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ================= SLIM CUSTOM HEADER =================
          _buildHeader(context),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(notice.title,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.person_outline,
                          size: 16, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(notice.teacher,
                          style: const TextStyle(color: Colors.grey)),
                      const SizedBox(width: 15),
                      const Icon(Icons.calendar_today,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(notice.date,
                          style: const TextStyle(color: Colors.grey)),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const Spacer(),
                          const Icon(Icons.download, color: Colors.blue),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SLIM HEADER METHOD
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 5,
        left: 4, // Minimal padding for tight arrow-to-text spacing
        right: 15,
        bottom: 5,
      ),
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            "Details",
            style: TextStyle(
              color: Colors.white,
              fontSize: 23, // Reduced font size to match other pages
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
