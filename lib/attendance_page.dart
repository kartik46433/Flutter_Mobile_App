import 'package:flutter/material.dart';
import 'subject_card.dart'; // Ensure this matches your file name

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: false, // Set this to false to allow titleSpacing to work
        titleSpacing: 0, // Reduces the gap between the back arrow and text
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Attendance",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // --- OVERALL SUMMARY CARD ---
            _buildOverallSummary(),

            const SizedBox(height: 25),
            const Text(
              "Your Subjects",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 15),

            // --- SUBJECT LIST ---
            const SubjectCard(
                subject: "Data Structures", attended: 22, total: 25),
            const SubjectCard(
                subject: "Operating Systems", attended: 18, total: 25),
            const SubjectCard(subject: "DBMS", attended: 24, total: 25),
            const SubjectCard(
                subject: "Computer Networks",
                attended: 15,
                total: 25), // Low attendance example
            const SubjectCard(subject: "AI & ML", attended: 20, total: 25),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildOverallSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Row(
        children: [
          // Circular Progress for Overall
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: 90,
                width: 90,
                child: CircularProgressIndicator(
                  value: 0.82,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey.shade100,
                  valueColor: const AlwaysStoppedAnimation(Colors.black),
                ),
              ),
              const Text(
                "82%",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )
            ],
          ),
          const SizedBox(width: 20),
          // Stats text
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Overall Attendance",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                "Good Job! Keep it up.",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              SizedBox(height: 5),
              Text(
                "Target: 75% for Exams",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
              ),
            ],
          )
        ],
      ),
    );
  }
}
