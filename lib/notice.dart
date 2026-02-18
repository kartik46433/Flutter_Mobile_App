import 'package:flutter/material.dart';

class Notice {
  final String title;
  final String description;
  final String teacher;
  final String date;
  final String? attachment;
  bool isNew;

  Notice({
    required this.title,
    required this.description,
    required this.teacher,
    required this.date,
    this.attachment,
    this.isNew = false,
  });
}

// Global list accessible by all pages
List<Notice> noticeList = [
  Notice(
    title: "Unit 1 Notes Uploaded",
    description:
        "All important topics covered regarding the upcoming semester exams.",
    teacher: "Prof. A. Desai",
    date: "28 Jul 2025",
    attachment: "unit1_notes.pdf",
    isNew: true,
  ),
  Notice(
    title: "ISA 2 Assignment",
    description:
        "Submit before the deadline. Late submissions will not be graded.",
    teacher: "Prof. R. Naik",
    date: "25 Jul 2025",
    attachment: "isa2_questions.pdf",
    isNew: true,
  ),
  Notice(
    title: "Lab Schedule Updated",
    description:
        "The new lab schedule for the computer department is now live.",
    teacher: "Prof. K. Sharma",
    date: "20 Jul 2025",
    isNew: false,
  ),
];
