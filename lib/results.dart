import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'result_model.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late Future<List<SubjectResult>> futureResult;

  @override
  void initState() {
    super.initState();
    futureResult = loadResult();
  }

  // ---------------- MOCK DATA ----------------
  Future<List<SubjectResult>> loadResult() async {
    await Future.delayed(const Duration(seconds: 1));
    final data = [
      {
        "code": "CSA401",
        "isa": 11,
        "see": 44,
        "theory": 55,
        "practical": 0,
        "total": 55,
        "grade": "B+"
      },
      {
        "code": "CSA402",
        "isa": 15,
        "see": 38,
        "theory": 53,
        "practical": 0,
        "total": 53,
        "grade": "B+"
      },
      {
        "code": "CSA403",
        "isa": 0,
        "see": 60,
        "theory": 60,
        "practical": 0,
        "total": 60,
        "grade": "B+"
      },
      {
        "code": "CSA404",
        "isa": 17,
        "see": 49,
        "theory": 0,
        "practical": 66,
        "total": 66,
        "grade": "A"
      },
    ];
    return data.map((e) => SubjectResult.fromJson(e)).toList();
  }

  // ---------------- MODERN PDF DOWNLOAD ----------------
  Future<void> downloadPdf(List<SubjectResult> list) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Container(
                padding:
                    const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: const pw.BoxDecoration(
                  border: pw.Border(
                      left: pw.BorderSide(color: PdfColors.blue800, width: 4)),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text("MES VASANT JOSHI COLLEGE",
                        style: pw.TextStyle(
                            fontSize: 20,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.blue800)),
                    pw.Text("OF ARTS & COMMERCE",
                        style: const pw.TextStyle(fontSize: 10)),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),

              // Student Info
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  _pdfInfoLabel("NAME", "Kartik Sangappa Surpur"),
                  _pdfInfoLabel("ROLL", "2305112"),
                  _pdfInfoLabel("COURSE", "BCA"),
                  _pdfInfoLabel("SEM", "III"),
                ],
              ),
              pw.SizedBox(height: 20),

              // Table
              pw.Table(
                border:
                    pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
                children: [
                  pw.TableRow(
                    decoration:
                        const pw.BoxDecoration(color: PdfColors.blue800),
                    children: [
                      _pdfCell("SUB", isHeader: true),
                      _pdfCell("ISA", isHeader: true),
                      _pdfCell("SEE", isHeader: true),
                      _pdfCell("TH", isHeader: true),
                      _pdfCell("PR", isHeader: true),
                      _pdfCell("TOT", isHeader: true),
                      _pdfCell("GR", isHeader: true),
                    ],
                  ),
                  ...list.map((e) => pw.TableRow(
                        children: [
                          _pdfCell(e.code),
                          _pdfCell(e.isa.toString()),
                          _pdfCell(e.see.toString()),
                          _pdfCell(e.theory.toString()),
                          _pdfCell(e.practical.toString()),
                          _pdfCell(e.total.toString(), isBold: true),
                          _pdfCell(e.grade, isBold: true),
                        ],
                      )),
                ],
              ),
              pw.SizedBox(height: 30),

              // Result Summary
              pw.Container(
                padding: const pw.EdgeInsets.all(10),
                decoration: pw.BoxDecoration(
                    color: PdfColors.blue800,
                    borderRadius: pw.BorderRadius.circular(4)),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    _pdfSummaryItem("SGPA", "8.30"),
                    _pdfSummaryItem("CGPA", "6.86"),
                    _pdfSummaryItem("RESULT", "PASS"),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    // Save to device
    final file = File("/storage/emulated/0/Download/result.pdf");
    await file.writeAsBytes(await pdf.save());

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("PDF Saved to Downloads")),
      );
    }
  }

  // --- PDF HELPER METHODS (Must be inside _ResultPageState) ---

  pw.Widget _pdfInfoLabel(String label, String value) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(label,
            style: const pw.TextStyle(fontSize: 7, color: PdfColors.grey600)),
        pw.Text(value,
            style: pw.TextStyle(fontSize: 10, fontWeight: pw.FontWeight.bold)),
      ],
    );
  }

  pw.Widget _pdfCell(String text,
      {bool isHeader = false, bool isBold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Center(
        child: pw.Text(
          text,
          style: pw.TextStyle(
            fontSize: 9,
            color: isHeader ? PdfColors.white : PdfColors.black,
            fontWeight: (isHeader || isBold)
                ? pw.FontWeight.bold
                : pw.FontWeight.normal,
          ),
        ),
      ),
    );
  }

  pw.Widget _pdfSummaryItem(String label, String value) {
    return pw.Column(
      children: [
        pw.Text(label,
            style: const pw.TextStyle(fontSize: 8, color: PdfColors.white)),
        pw.Text(value,
            style: pw.TextStyle(
                fontSize: 12,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.white)),
      ],
    );
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Semester Result"),
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 0, 0, 0)),
      body: FutureBuilder<List<SubjectResult>>(
        future: futureResult,
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());
          final list = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                studentHeaderUI(),
                const SizedBox(height: 12),
                resultTableUI(list),
                const SizedBox(height: 12),
                summaryCardUI(),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => downloadPdf(list),
                  icon: const Icon(Icons.download),
                  label: const Text("Download PDF"),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50)),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // --- UI WIDGETS ---
  Widget studentHeaderUI() {
    return const Card(
      child: ListTile(
        title: Text("Kartik Sangappa Surpur",
            style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Roll: 2305112 | BCA | Semester III"),
      ),
    );
  }

  Widget resultTableUI(List<SubjectResult> list) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade300),
        children: [
          const TableRow(
            decoration: BoxDecoration(color: Color(0xFFE3F2FD)),
            children: [
              _CellUI("SUB", b: true),
              _CellUI("ISA", b: true),
              _CellUI("SEE", b: true),
              _CellUI("TH", b: true),
              _CellUI("PR", b: true),
              _CellUI("TOT", b: true),
              _CellUI("GR", b: true),
            ],
          ),
          ...list.map((r) => TableRow(
                children: [
                  _CellUI(r.code),
                  _CellUI(r.isa.toString()),
                  _CellUI(r.see.toString()),
                  _CellUI(r.theory.toString()),
                  _CellUI(r.practical.toString()),
                  _CellUI(r.total.toString()),
                  _CellUI(r.grade),
                ],
              ))
        ],
      ),
    );
  }

  Widget summaryCardUI() {
    return const Card(
      color: Colors.blue,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _SumUI("SGPA", "8.30"),
            _SumUI("CGPA", "6.86"),
            _SumUI("RESULT", "PASS"),
          ],
        ),
      ),
    );
  }
}

// Simple internal helpers for the UI part
class _CellUI extends StatelessWidget {
  final String t;
  final bool b;
  const _CellUI(this.t, {this.b = false});
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(8),
      child: Center(
          child: Text(t,
              style: TextStyle(
                  fontWeight: b ? FontWeight.bold : FontWeight.normal))));
}

class _SumUI extends StatelessWidget {
  final String l, v;
  const _SumUI(this.l, this.v);
  @override
  Widget build(BuildContext context) => Column(children: [
        Text(l, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        Text(v,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
      ]);
}
