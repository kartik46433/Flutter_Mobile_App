import 'package:flutter/material.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              height: 280,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 36,
                        backgroundImage: AssetImage("assets/logo1.jpeg"),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Jane Cooper",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "7th Sem (Final Year)",
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "Computer Science & Engg",
                            style: TextStyle(color: Colors.white70),
                          ),
                          Text(
                            "20180212453",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ================= GRID =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                children: const [
                  DashboardTile(icon: Icons.school, title: "Academic Info"),
                  DashboardTile(icon: Icons.assignment, title: "Assignments"),
                  DashboardTile(
                    icon: Icons.calendar_month,
                    title: "Time Table",
                  ),
                  DashboardTile(icon: Icons.event, title: "Upcoming Event"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ================= VIEW RESULTS =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.emoji_events, color: Color(0xFF1F5FD9)),
                    SizedBox(width: 10),
                    Text(
                      "View Results",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ================= EVENTS =================
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1F5FD9), Color(0xFF8A6BD8)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Events",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "AICTE supported Unique Mega Quiz Contest at Industry by Academic Conclave at India International Science Festival (IISF 2020)",
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "View All",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 90),
          ],
        ),
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) {
          setState(() => index = i);
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

// ================= TILE =================
class DashboardTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const DashboardTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: const Color(0xFF1F5FD9)),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
