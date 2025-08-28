class SubjectAttendance {
  final String code;
  final String name;
  final int totalClasses;
  final int attendedClasses;
  final double? percentage;

  const SubjectAttendance({
    required this.code,
    required this.name,
    required this.totalClasses,
    required this.attendedClasses,
    this.percentage,
  });

  factory SubjectAttendance.fromJson(Map<String, dynamic> json) => SubjectAttendance(
    code: json['subject_code'] as String,
    name: json['subject_name'] as String,
    totalClasses: json['total_classes'] as int,
    attendedClasses: json['attended_classes'] as int,
    percentage: (json['percentage'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'subject_code': code,
    'subject_name': name,
    'total_classes': totalClasses,
    'attended_classes': attendedClasses,
    'percentage': percentage,
  };
}

class AttendanceSummary {
  final int total;
  final int attended;
  final double percentage;

  const AttendanceSummary({
    required this.total,
    required this.attended,
    required this.percentage,
  });

  factory AttendanceSummary.fromJson(Map<String, dynamic> json) => AttendanceSummary(
    total: json['total'] as int,
    attended: json['attended'] as int,
    percentage: (json['percentage'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'total': total,
    'attended': attended,
    'percentage': percentage,
  };
}
