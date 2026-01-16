import 'package:flutter/material.dart';
import 'change_password.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_reset, size: 80, color: Colors.blue),
            const SizedBox(height: 20),

            const Text(
              "Reset Password",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            const Text(
              "Enter your username to reset your password",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                hintText: "Username",
                prefixIcon: const Icon(Icons.person),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChangePasswordPage(),
                    ),
                  );
                },
                child: const Text(
                  "Send Reset Link",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
