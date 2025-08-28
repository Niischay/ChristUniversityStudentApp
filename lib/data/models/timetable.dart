class Period {
  final int dayOfWeek; // 1-7
  final String startTime; // HH:mm
  final String endTime;
  final String subject;
  final String? room;
  final String? faculty;

  const Period({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.subject,
    this.room,
    this.faculty,
  });

  factory Period.fromJson(Map<String, dynamic> json) => Period(
    dayOfWeek: json['day_of_week'] as int,
    startTime: json['start_time'] as String,
    endTime: json['end_time'] as String,
    subject: json['subject'] as String,
    room: json['room'] as String?,
    faculty: json['faculty'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'day_of_week': dayOfWeek,
    'start_time': startTime,
    'end_time': endTime,
    'subject': subject,
    'room': room,
    'faculty': faculty,
  };
}

class Timetable {
  final DateTime weekStart;
  final List<Period> periods;

  const Timetable({
    required this.weekStart,
    required this.periods,
  });

  factory Timetable.fromJson(Map<String, dynamic> json) => Timetable(
    weekStart: DateTime.parse(json['week_start'] as String),
    periods: (json['periods'] as List<dynamic>)
        .map((e) => Period.fromJson(e as Map<String, dynamic>))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'week_start': weekStart.toIso8601String(),
    'periods': periods.map((e) => e.toJson()).toList(),
  };
}
