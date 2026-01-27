import 'package:flutter/material.dart';
import 'profile.dart';
import 'timetable.dart';
import 'attendance.dart';

/// ================= DASHBOARD MODEL =================
class DashboardItem {
  final String title;
  final IconData icon;
  final Color color;

  DashboardItem({required this.title, required this.icon, required this.color});
}

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int currentIndex = 1;

  /// ================= DYNAMIC DASHBOARD LIST =================
  final List<DashboardItem> dashboardItems = [
    DashboardItem(
      title: "Academic",
      icon: Icons.school,
      color: Color(0xFF4CAF50),
    ),
    DashboardItem(
      title: "Assignments",
      icon: Icons.assignment,
      color: Color(0xFFFF9800),
    ),
    DashboardItem(
      title: "Timetable",
      icon: Icons.calendar_month,
      color: Color(0xFF03A9F4),
    ),
    DashboardItem(
      title: "Results",
      icon: Icons.emoji_events,
      color: Color(0xFF9C27B0),
    ),
    DashboardItem(
      title: "Attendance",
      icon: Icons.percent,
      color: Color(0xFF009688),
    ),
    DashboardItem(
      title: "Notices",
      icon: Icons.notifications,
      color: Color(0xFF607D8B),
    ),
    DashboardItem(
      title: "Events",
      icon: Icons.event_available,
      color: Color(0xFFE91E63),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),

      body: Column(
        children: [
          // ================= HEADER =================
          Container(
            height: 210,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1F5FD9), Color(0xFF5B8DF7)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 34,
                      backgroundImage: AssetImage("assets/logo1.jpeg"),
                    ),
                    const SizedBox(width: 14),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Welcome 👋",
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Jane Cooper",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Computer Science • 7th Sem",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ================= ATTENDANCE CARD =================
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AttendanceCard(percentage: 82),
          ),

          const SizedBox(height: 16),

          // ================= DASHBOARD GRID (SCROLLABLE) =================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: dashboardItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.95,
                ),
                itemBuilder: (context, index) {
                  final item = dashboardItems[index];

                  return GestureDetector(
                    onTap: () {
                      switch (item.title) {
                        case "Timetable":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TimeTablePage(),
                            ),
                          );
                          break;

                        case "Attendance":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AttendancePage(),
                            ),
                          );
                          break;

                        case "Profile":
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StudentProfilePage(),
                            ),
                          );
                          break;
                      }
                    },
                    child: DashboardCard(
                      icon: item.icon,
                      title: item.title,
                      color: item.color,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() => currentIndex = i);
          if (i == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const StudentProfilePage(),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "Alerts",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// ================= DASHBOARD CARD (WITH HERO) =================
class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Hero(
              tag: title, // 🔥 HERO TAG
              child: Icon(icon, size: 22, color: color),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

// ================= ATTENDANCE CARD =================
class AttendanceCard extends StatelessWidget {
  final int percentage;

  const AttendanceCard({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    final bool isLow = percentage < 75;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Attendance",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$percentage%",
                style: const TextStyle(
                  fontSize: 26,
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
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor: AlwaysStoppedAnimation<Color>(
                isLow ? Colors.red : const Color(0xFF1F5FD9),
              ),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            "Minimum required attendance: 75%",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
