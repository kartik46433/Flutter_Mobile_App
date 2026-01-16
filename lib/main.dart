import 'package:flutter/material.dart';
import 'forget.dart'; // or forgot.dart (your filename)
import 'home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage());
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FF),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Top Blue Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    // Circular Logo
                    Container(
                      width: 120,
                      height: 120,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 14, 234, 205),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/logo1.jpeg', // make sure this name is correct
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // App Name
                    const Text(
                      "SmartCampus",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // Login Card
              Padding(
                padding: const EdgeInsets.all(24),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 35),

                        // Username
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

                        const SizedBox(height: 20),

                        // Password
                        TextField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: const Text("Forgot Password?"),
                          ),
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (usernameController.text.isEmpty ||
                                  passwordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please enter username and password",
                                    ),
                                  ),
                                );
                                return;
                              }

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const StudentDashboard(),
                                ),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
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
