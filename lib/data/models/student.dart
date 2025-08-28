class Student {
  final String regNo;
  final String name;
  final String? program;
  final int? semester;
  final String? email;

  const Student({
    required this.regNo,
    required this.name,
    this.program,
    this.semester,
    this.email,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    regNo: json['reg_no'] as String,
    name: json['name'] as String,
    program: json['program'] as String?,
    semester: json['semester'] as int?,
    email: json['email'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'reg_no': regNo,
    'name': name,
    'program': program,
    'semester': semester,
    'email': email,
  };
}
