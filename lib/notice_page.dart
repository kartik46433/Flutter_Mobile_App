import 'package:flutter/material.dart';
import 'notice.dart'; // Import the model and list
import 'notice_detail_page.dart'; // Import the detail page

class NoticePage extends StatefulWidget {
  const NoticePage({super.key});

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      // We remove the standard AppBar and use a Column to place a custom header
      body: Column(
        children: [
          // ================= SLIM CUSTOM HEADER =================
          _buildHeader(context),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: noticeList.length,
              itemBuilder: (context, index) {
                final notice = noticeList[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    onTap: () async {
                      if (notice.isNew) {
                        setState(() => notice.isNew = false);
                      }
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => NoticeDetailPage(notice: notice)),
                      );
                      setState(() {});
                    },
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            notice.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        if (notice.isNew)
                          const Badge(
                              label: Text("NEW"), backgroundColor: Colors.red),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(notice.description,
                            maxLines: 2, overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(notice.teacher,
                                style: const TextStyle(
                                    color: Colors.blue, fontSize: 12)),
                            Text(notice.date,
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
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
        left: 4, // Minimal left padding for the arrow
        right: 15,
        bottom: 5, // Tight bottom padding for slim look
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
          // Space between arrow and text is effectively 0 here due to IconButton padding
          const Text(
            "Notices",
            style: TextStyle(
              color: Colors.white,
              fontSize: 23, // Reduced font size
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
