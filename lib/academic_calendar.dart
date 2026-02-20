import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AcademicCalendarPage extends StatefulWidget {
  const AcademicCalendarPage({super.key});

  @override
  State<AcademicCalendarPage> createState() => _AcademicCalendarPageState();
}

class _AcademicCalendarPageState extends State<AcademicCalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  final Set<DateTime> examDates = {
    DateTime(2025, 7, 25),
    DateTime(2025, 9, 20),
    DateTime(2025, 10, 5),
  };

  final Set<DateTime> holidayDates = {
    DateTime(2025, 8, 15),
    DateTime(2025, 10, 2),
  };

  bool _isExam(DateTime day) =>
      examDates.contains(DateTime(day.year, day.month, day.day));

  bool _isHoliday(DateTime day) =>
      holidayDates.contains(DateTime(day.year, day.month, day.day));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: Column(
        // Changed to Column to separate the custom header
        children: [
          // ================= SLIM CUSTOM HEADER =================
          _buildHeader(context),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // --- MODERN CALENDAR CARD ---
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: TableCalendar(
                        firstDay: DateTime.utc(2024, 1, 1),
                        lastDay: DateTime.utc(2030, 12, 31),
                        focusedDay: _focusedDay,
                        rowHeight: 52,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                        },
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          leftChevronIcon:
                              Icon(Icons.chevron_left, color: Colors.black),
                          rightChevronIcon:
                              Icon(Icons.chevron_right, color: Colors.black),
                        ),
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          todayTextStyle: const TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold),
                          selectedDecoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          defaultTextStyle:
                              const TextStyle(color: Color(0xFF333333)),
                          weekendTextStyle:
                              const TextStyle(color: Colors.redAccent),
                          outsideDaysVisible: false,
                        ),
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) {
                            if (_isExam(day)) {
                              return _buildCustomDay(day, Colors.red);
                            }
                            if (_isHoliday(day)) {
                              return _buildCustomDay(day, Colors.green);
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // --- LEGEND SECTION ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _modernLegend(Colors.red, "Exams"),
                        _modernLegend(Colors.green, "Holidays"),
                        _modernLegend(Colors.orange, "Today"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // --- EVENT DETAILS SECTION ---
                  _buildEventDetails(),
                  const SizedBox(height: 30),
                ],
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
        left: 4,
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
          const Text(
            "Academic Calendar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20, // Reduced font size
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _modernLegend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(text,
            style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 13,
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildCustomDay(DateTime day, Color color) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${day.day}',
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 2),
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          )
        ],
      ),
    );
  }

  Widget _buildEventDetails() {
    String message = "No specific events scheduled.";
    Color accentColor = Colors.blueGrey;

    if (_selectedDay != null) {
      if (_isExam(_selectedDay!)) {
        message = "Examination scheduled for this date.";
        accentColor = Colors.red;
      } else if (_isHoliday(_selectedDay!)) {
        message = "Public Holiday / College Break.";
        accentColor = Colors.green;
      }
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accentColor.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: accentColor),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                  color: accentColor.withAlpha(200),
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
