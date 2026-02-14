import 'package:flutter/material.dart';
import 'notice_detail_page.dart';

class Notice {
  final String title;
  final String description;
  final String teacher;
  final String date;
  final String? attachment;
  bool isNew;

  Notice({
    required this.title,
    required this.description,
    required this.teacher,
    required this.date,
    this.attachment,
    this.isNew = false,
  });
}

// 🔴 GLOBAL NOTICE LIST
List<Notice> noticeList = [
  Notice(
    title: "Unit 1 Notes Uploaded",
    description: "All important topics covered.",
    teacher: "Prof. A. Desai",
    date: "28 Jul 2025",
    attachment: "unit1_notes.pdf",
    isNew: true,
  ),
  Notice(
    title: "ISA 2 Assignment",
    description: "Submit before deadline.",
    teacher: "Prof. R. Naik",
    date: "25 Jul 2025",
    attachment: "isa2_questions.pdf",
    isNew: true,
  ),
  Notice(
    title: "Lab Schedule Updated",
    description: "New lab schedule uploaded.",
    teacher: "Prof. K. Sharma",
    date: "20 Jul 2025",
    isNew: false,
  ),
];

class NoticePage extends StatefulWidget {
  NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme:
            const IconThemeData(color: Colors.white), // 🔥 makes arrow white
        title: const Text(
          "Notices",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: noticeList.length,
        itemBuilder: (context, index) {
          final notice = noticeList[index];

          return GestureDetector(
            onTap: () async {
              // 🔥 Remove NEW badge
              if (notice.isNew) {
                setState(() {
                  notice.isNew = false;
                });
              }

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => NoticeDetailPage(notice: notice),
                ),
              );

              setState(() {});
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notice.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (notice.isNew)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "NEW",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notice.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        notice.teacher,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        notice.date,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
