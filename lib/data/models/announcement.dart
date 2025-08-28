class Announcement {
  final int id;
  final String title;
  final String? body;
  final DateTime date;

  const Announcement({
    required this.id,
    required this.title,
    this.body,
    required this.date,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
    id: json['id'] as int,
    title: json['title'] as String,
    body: json['body'] as String?,
    date: DateTime.parse(json['date'] as String),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'body': body,
    'date': date.toIso8601String(),
  };
}
