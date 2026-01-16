import 'package:flutter/material.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String passwordStrength = "";
  Color strengthColor = Colors.grey;

  void checkPasswordStrength(String password) {
    if (password.length < 6) {
      setState(() {
        passwordStrength = "Weak";
        strengthColor = Colors.red;
      });
    } else if (password.length < 10) {
      setState(() {
        passwordStrength = "Medium";
        strengthColor = Colors.orange;
      });
    } else {
      setState(() {
        passwordStrength = "Strong";
        strengthColor = Colors.green;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock_outline, size: 80, color: Colors.blue),

              const SizedBox(height: 20),

              const Text(
                "Create New Password",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              const Text(
                "Your new password must be different from the old one",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // New Password
              TextField(
                controller: newPasswordController,
                obscureText: true,
                onChanged: checkPasswordStrength,
                decoration: InputDecoration(
                  hintText: "New Password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // Password Strength Indicator
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  passwordStrength.isEmpty
                      ? "Password strength"
                      : "Strength: $passwordStrength",
                  style: TextStyle(
                    color: strengthColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Confirm Password
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (newPasswordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please fill all fields")),
                      );
                      return;
                    }

                    if (newPasswordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
                      );
                      return;
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Password changed successfully"),
                      ),
                    );

                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text(
                    "Change Password",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
