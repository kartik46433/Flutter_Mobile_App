import 'package:flutter/material.dart';
import 'attendance_page.dart';
import 'profile.dart';
import 'notice.dart';
import 'academic_calendar.dart';
import 'timetable.dart';
import 'results.dart';
import 'user_data.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // 🔴 Calculate NEW notice count
    final int newCount = noticeList.where((n) => n.isNew).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      body: Column(
        children: [
          // ================= HEADER =================
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 12,
              left: 16,
              right: 16,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "MES",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    // 🔥 PROFILE IMAGE (Dynamic)
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StudentProfilePage(),
                          ),
                        ).then((_) {
                          setState(() {}); // 🔥 refresh
                        });
                      },
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: UserData.profileImage != null
                            ? FileImage(UserData.profileImage!)
                            : const AssetImage("assets/logo1.jpeg")
                                as ImageProvider,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  "Kartik Sangappa Surpur",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  "2305112 | kartik@gmail.com",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 18,
                  runSpacing: 10,
                  children: const [
                    InfoItem("Branch", "BCA"),
                    InfoItem("Sem", "VI"),
                    InfoItem("Division", "B"),
                    InfoItem("Roll No.", "12"),
                    InfoItem("Batch", "2024-25"),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // ================= GRID =================
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: size.width < 360 ? 2 : 3,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.95,
                ),
                children: [
                  DashboardCard(
                    icon: Icons.calendar_month,
                    title: "Academic Calendar",
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AcademicCalendarPage(),
                        ),
                      );
                    },
                  ),

                  DashboardCard(
                    icon: Icons.schedule,
                    title: "Time Table",
                    color: Colors.teal,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TimeTablePage(),
                        ),
                      );
                    },
                  ),

                  DashboardCard(
                    icon: Icons.percent,
                    title: "Attendance",
                    color: Colors.indigo,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AttendancePage(),
                        ),
                      );
                    },
                  ),

                  // 🔴 NOTICE WITH COUNT
                  DashboardCard(
                    icon: Icons.notifications,
                    title: "Notice",
                    color: Colors.orange,
                    badgeCount: newCount,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NoticePage(),
                        ),
                      ).then((_) {
                        setState(() {});
                      });
                    },
                  ),

                  DashboardCard(
                    icon: Icons.bar_chart,
                    title: "Results",
                    color: Colors.redAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ResultPage(),
                        ),
                      );
                    },
                  ),

                  DashboardCard(
                    icon: Icons.account_balance_wallet,
                    title: "Fees",
                    color: Colors.green,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "App Version : 1.0.1",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// ================= INFO ITEM =================
class InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const InfoItem(this.title, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

// ================= DASHBOARD CARD =================
class DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onTap;
  final int badgeCount;

  const DashboardCard({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    required this.onTap,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: color.withOpacity(0.15),
                  child: Icon(
                    icon,
                    color: color,
                    size: 22,
                  ),
                ),
                if (badgeCount > 0)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        badgeCount > 9 ? "9+" : badgeCount.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Flexible(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
