import 'package:flutter/material.dart';

class AttendanceDetailPage extends StatelessWidget {
  final String subject;

  const AttendanceDetailPage({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    List<String> days = List.generate(30, (index) => "${index + 1}/8");
    List<List<String>> data = List.generate(
      30,
      (day) => List.generate(6, (slot) => (day + slot) % 4 == 0 ? "A" : "P"),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // ================= SLIM CUSTOM HEADER =================
          _buildHeader(context),

          // Sub-header for Slots explanation
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey.shade50,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.info_outline, size: 14, color: Colors.grey),
                SizedBox(width: 8),
                Text("S1 to S6 represents Daily Lecture Slots",
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: 25,
                  headingRowColor:
                      MaterialStateProperty.all(Colors.grey.shade100),
                  columns: [
                    const DataColumn(
                        label: Text('Date',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    for (int i = 1; i <= 6; i++)
                      DataColumn(
                          label: Text('S$i',
                              style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: List.generate(days.length, (i) {
                    return DataRow(cells: [
                      DataCell(Text(days[i],
                          style: const TextStyle(fontWeight: FontWeight.w500))),
                      for (int j = 0; j < 6; j++)
                        DataCell(_buildStatusIcon(data[i][j])),
                    ]);
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SLIM HEADER METHOD
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 5,
        left: 4, // Minimal padding for tight arrow-to-text spacing
        right: 15,
        bottom: 5,
      ),
      decoration: const BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            onPressed: () => Navigator.pop(context),
          ),
          Expanded(
            // Added Expanded to handle long subject names
            child: Text(
              subject,
              overflow: TextOverflow
                  .ellipsis, // Prevents overflow if subject name is very long
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20, // Reduced font size
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusIcon(String status) {
    bool isPresent = status == "P";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isPresent
            ? Colors.green.withOpacity(0.1)
            : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isPresent ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
