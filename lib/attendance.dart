import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),

      body: Column(
        children: [
          // ================= HEADER =================
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1F5FD9), Color(0xFF5B8DF7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Attendance",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Semester Attendance Overview",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ================= OVERALL ATTENDANCE =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OverallAttendanceCard(percentage: 82),
          ),

          const SizedBox(height: 16),

          // ================= SUBJECT LIST =================
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                SubjectAttendanceCard(
                  subject: "Data Structures",
                  attended: 32,
                  total: 40,
                ),
                SubjectAttendanceCard(
                  subject: "Operating Systems",
                  attended: 28,
                  total: 40,
                ),
                SubjectAttendanceCard(subject: "DBMS", attended: 30, total: 38),
                SubjectAttendanceCard(
                  subject: "Computer Networks",
                  attended: 22,
                  total: 35,
                ),
                SubjectAttendanceCard(
                  subject: "AI Lab",
                  attended: 16,
                  total: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= OVERALL CARD =================
class OverallAttendanceCard extends StatelessWidget {
  final int percentage;

  const OverallAttendanceCard({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    final bool isLow = percentage < 75;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Overall Attendance",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$percentage%",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1F5FD9),
                ),
              ),
              Text(
                isLow ? "Low Attendance" : "Good Attendance",
                style: TextStyle(
                  color: isLow ? Colors.red : Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                isLow ? Colors.red : const Color(0xFF1F5FD9),
              ),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Minimum required attendance: 75%",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// ================= SUBJECT CARD =================
class SubjectAttendanceCard extends StatelessWidget {
  final String subject;
  final int attended;
  final int total;

  const SubjectAttendanceCard({
    super.key,
    required this.subject,
    required this.attended,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage = (attended / total) * 100;
    final bool isLow = percentage < 75;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subject,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "${percentage.toStringAsFixed(0)}%",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isLow ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            "Attended: $attended / $total classes",
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: attended / total,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                isLow ? Colors.red : const Color(0xFF1F5FD9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
