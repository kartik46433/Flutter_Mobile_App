import 'package:flutter/material.dart';

class AttendanceDetailPage extends StatelessWidget {
  final String subject;

  const AttendanceDetailPage({
    super.key,
    required this.subject,
  });

  @override
  Widget build(BuildContext context) {
    // Generate 30 days automatically
    List<String> days = List.generate(30, (index) => "${index + 1}/8");

    // Generate attendance data (30 days × 6 slots)
    List<List<String>> data = List.generate(
      30,
      (day) => List.generate(
        6,
        (slot) => (day + slot) % 4 == 0 ? "A" : "P",
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          subject,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER ROW
              Row(
                children: [
                  _headerCell("Date"),
                  for (int i = 1; i <= 6; i++) _headerCell("S$i"),
                ],
              ),

              // DATA ROWS
              for (int i = 0; i < days.length; i++)
                Row(
                  children: [
                    _dateCell(days[i]),
                    for (int j = 0; j < 6; j++) _statusCell(data[i][j]),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HEADER CELL =================
  Widget _headerCell(String text) {
    return Container(
      width: 70,
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  // ================= DATE CELL =================
  Widget _dateCell(String text) {
    return Container(
      width: 70,
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(text),
    );
  }

  // ================= STATUS CELL =================
  Widget _statusCell(String status) {
    return Container(
      width: 70,
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: status == "P" ? Colors.green.shade100 : Colors.red.shade100,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: status == "P" ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
