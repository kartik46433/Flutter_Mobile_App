import 'package:flutter/material.dart';

class TimeTablePage extends StatefulWidget {
  const TimeTablePage({super.key});

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  int selectedIndex = 0;
  final List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FD),
      body: Column(
        children: [
          // ================= HEADER WITH DEFAULT ARROW =================
          _buildHeader(context),

          const SizedBox(height: 15),

          // ================= DAY SELECTOR =================
          _buildDaySelector(),

          const SizedBox(height: 10),

          // ================= TIMETABLE LIST =================
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                const ModernTimeCard(
                  time: "08:15 AM",
                  duration: "60 min",
                  subject: "Data Structures",
                  faculty: "Dr. A. Sharma",
                  room: "Room 1",
                  color: Colors.indigo,
                  icon: Icons.code,
                ),
                const ModernTimeCard(
                  time: "09:15 AM",
                  duration: "60 min",
                  subject: "Operating Systems",
                  faculty: "Prof. R. Kumar",
                  room: "Room 2",
                  color: Colors.blueAccent,
                  icon: Icons.settings_input_component,
                ),
                const ModernTimeCard(
                  time: "10:15 AM",
                  duration: "60 min",
                  subject: "Computer Networks",
                  faculty: "Dr. S. Verma",
                  room: "Lab 1",
                  color: Colors.teal,
                  icon: Icons.lan,
                ),

                // 🔥 RECESS (11:15 - 11:30)
                const RecessCard(time: "11:15 AM", duration: "15 min"),

                const ModernTimeCard(
                  time: "11:30 AM",
                  duration: "60 min",
                  subject: "DBMS",
                  faculty: "Ms. P. Singh",
                  room: "Room 5",
                  color: Colors.orangeAccent,
                  icon: Icons.storage,
                ),

                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "End of Lectures",
                    style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                        letterSpacing: 1.2),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 5,
        left: 8, // Reduced left padding for the default IconButton
        right: 20,
        bottom: 5,
      ),
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        children: [
          // DEFAULT BACK BUTTON
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(
              width: 4), // Minimal space as IconButton has its own padding
          const Text(
            "Time Table",
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySelector() {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: days.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => setState(() => selectedIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.only(right: 12, top: 5, bottom: 5),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              decoration: BoxDecoration(
                color: isSelected ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4))
                      ]
                    : [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 4)
                      ],
              ),
              alignment: Alignment.center,
              child: Text(
                days[index],
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ================= MODERN SUBJECT CARD =================
class ModernTimeCard extends StatelessWidget {
  final String time;
  final String duration;
  final String subject;
  final String faculty;
  final String room;
  final Color color;
  final IconData icon;

  const ModernTimeCard({
    super.key,
    required this.time,
    required this.duration,
    required this.subject,
    required this.faculty,
    required this.room,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Text(time.split(" ")[0],
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            Text(time.split(" ")[1],
                style: const TextStyle(color: Colors.grey, fontSize: 10)),
            Container(
              width: 2,
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  colors: [color, color.withOpacity(0.1)],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 15,
                    offset: const Offset(0, 8)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12)),
                      child: Icon(icon, color: color, size: 20),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(room,
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(subject,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.person_outline,
                        size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(faculty,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 13)),
                    const Spacer(),
                    Text(duration,
                        style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 11,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ================= MODERN RECESS CARD =================
class RecessCard extends StatelessWidget {
  final String time;
  final String duration;

  const RecessCard({super.key, required this.time, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 45),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.orange.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.orange.withOpacity(0.1)),
            ),
            child: Row(
              children: [
                const Icon(Icons.coffee, color: Colors.orange, size: 18),
                const SizedBox(width: 12),
                const Text("Short Break",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.orange)),
                const Spacer(),
                Text(duration,
                    style: const TextStyle(color: Colors.orange, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
