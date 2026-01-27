import 'package:flutter/material.dart';

class TimeTablePage extends StatelessWidget {
  const TimeTablePage({super.key});

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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🔙 Back Button
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 🕒 Title
                    const Text(
                      "Time Table",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),

                    const SizedBox(height: 6),

                    // 📅 Subtitle (optional but professional)
                    Text(
                      "Today • ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ================= DAY SELECTOR =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                DayChip(day: "Mon", active: true),
                DayChip(day: "Tue"),
                DayChip(day: "Wed"),
                DayChip(day: "Thu"),
                DayChip(day: "Fri"),
                DayChip(day: "Sat"),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ================= TIMETABLE LIST =================
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: const [
                TimeTableCard(
                  time: "09:00 - 10:00",
                  subject: "Data Structures",
                  faculty: "Dr. A. Sharma",
                  room: "Room 301",
                  color: Color(0xFF4CAF50),
                ),
                TimeTableCard(
                  time: "10:00 - 11:00",
                  subject: "Operating Systems",
                  faculty: "Prof. R. Kumar",
                  room: "Room 210",
                  color: Color(0xFF03A9F4),
                ),
                TimeTableCard(
                  time: "11:15 - 12:15",
                  subject: "DBMS",
                  faculty: "Ms. P. Singh",
                  room: "Lab 2",
                  color: Color(0xFFFF9800),
                ),
                TimeTableCard(
                  time: "01:00 - 03:00",
                  subject: "AI Lab",
                  faculty: "Dr. N. Mehta",
                  room: "Lab 5",
                  color: Color(0xFF9C27B0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ================= DAY CHIP =================
class DayChip extends StatelessWidget {
  final String day;
  final bool active;

  const DayChip({super.key, required this.day, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: active ? const Color(0xFF1F5FD9) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
        ],
      ),
      child: Text(
        day,
        style: TextStyle(
          color: active ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// ================= TIMETABLE CARD =================
class TimeTableCard extends StatelessWidget {
  final String time;
  final String subject;
  final String faculty;
  final String room;
  final Color color;

  const TimeTableCard({
    super.key,
    required this.time,
    required this.subject,
    required this.faculty,
    required this.room,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12),
        ],
      ),
      child: Row(
        children: [
          // Time indicator
          Container(
            width: 6,
            height: 70,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
          ),

          const SizedBox(width: 14),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
                const SizedBox(height: 6),
                Text(
                  subject,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(faculty, style: const TextStyle(color: Colors.grey)),
                Text(room, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
