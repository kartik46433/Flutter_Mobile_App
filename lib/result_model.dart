class SubjectResult {
  final String code;
  final int isa;
  final int see;
  final int theory;
  final int practical;
  final int total;
  final String grade;

  SubjectResult({
    required this.code,
    required this.isa,
    required this.see,
    required this.theory,
    required this.practical,
    required this.total,
    required this.grade,
  });

  factory SubjectResult.fromJson(Map<String, dynamic> json) {
    return SubjectResult(
      code: json['code'],
      isa: json['isa'],
      see: json['see'],
      theory: json['theory'],
      practical: json['practical'],
      total: json['total'],
      grade: json['grade'],
    );
  }
}
