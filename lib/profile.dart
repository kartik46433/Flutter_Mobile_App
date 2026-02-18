import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'user_data.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // ================= IMAGE PICK =================
  Future<void> _pickImage(ImageSource source) async {
    final XFile? picked =
        await _picker.pickImage(source: source, imageQuality: 80);

    if (picked != null) {
      setState(() {
        _image = File(picked.path);
        UserData.profileImage = _image; // 🔥 SAVE GLOBALLY
      });
    }
    Navigator.pop(context);
  }

  void _showPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 12),
            const Text(
              "Add Profile Photo",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Take Photo"),
              onTap: () => _pickImage(ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Choose from Gallery"),
              onTap: () => _pickImage(ImageSource.gallery),
            ),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ================= BLACK HEADER =================
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 1,
                bottom: 10,
              ),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),

                  const SizedBox(height: 5),

                  // 🔥 PROFILE IMAGE
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 43,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 38,
                          backgroundImage: UserData.profileImage != null
                              ? FileImage(UserData.profileImage!)
                              : const AssetImage("assets/logo1.jpeg")
                                  as ImageProvider,
                        ),
                      ),
                      GestureDetector(
                        onTap: _showPicker,
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.orange,
                          child: Icon(Icons.camera_alt,
                              size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Kartik Surpur",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "Active",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            _section(
              title: "Education Details",
              icon: Icons.school,
              children: const [
                _InfoRow("Branch", "CSE"),
                _InfoRow("Enrollment No.", "250101010032"),
                _InfoRow("Division", "CSE - 1"),
                _InfoRow("Sem | Roll No.", "1 | 32"),
              ],
            ),

            _section(
              title: "Student Contact Details",
              icon: Icons.person,
              children: const [
                _InfoRow("Mobile No.", "8678743423"),
                _InfoRow("Email", "Kartik@gmail.com"),
              ],
            ),

            _section(
              title: "Parents Contact Details",
              icon: Icons.people,
              children: const [
                _InfoRow("Father Phone", "8967345619"),
                _InfoRow("Mother Phone", "9765637831"),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  // ================= SECTION CARD =================
  static Widget _section({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
