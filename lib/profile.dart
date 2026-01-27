import 'package:flutter/material.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= HEADER =================
            Stack(
              children: [
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
                ),

                // Back Button
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),

                // Profile Avatar
                Positioned(
                  bottom: 5,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 42,
                        backgroundImage: const AssetImage("assets/logo1.jpeg"),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ================= NAME =================
            const Text(
              "Jane Cooper",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              "Bachelor of Computer Applications",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 24),

            // ================= ABOUT =================
            _sectionCard(
              title: "About",
              children: const [
                _InfoRow("Student ID", "20180212453"),
                _InfoRow("Semester", "6th (Final Year)"),
              ],
            ),

            // ================= ACADEMIC =================
            _sectionCard(
              title: "Academic Details",
              children: const [
                _InfoRow("Branch", "Computer Science & Engg"),
                _InfoRow("Roll No", "23"),
                _InfoRow("Enrollment", "ENR00012345"),
              ],
            ),

            // ================= CONTACT =================
            _sectionCard(
              title: "Contact Information",
              children: const [
                _InfoRow("Email", "janecooper@college.edu"),
                _InfoRow("Phone", "+91 98765 43210"),
              ],
            ),
            _sectionCard(
              title: "Parent Details",
              children: const [
                _InfoRow("Father Name", "Robert Cooper"),
                _InfoRow("Father Phone", "+91 98765 43211"),
              ],
            ),

            const SizedBox(height: 30),

            // ================= LOGOUT =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Logout", style: TextStyle(fontSize: 16)),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ================= SECTION CARD =================
  static Widget _sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }
}

// ================= INFO ROW =================
class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
