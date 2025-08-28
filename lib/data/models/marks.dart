class MarkItem {
  final String subject;
  final double? internal;
  final double? external;
  final double? total;
  final String? grade;
  final double? cia1;
  final double? cia2;
  final double? cia3;

  const MarkItem({
    required this.subject,
    this.internal,
    this.external,
    this.total,
    this.grade,
    this.cia1,
    this.cia2,
    this.cia3,
  });

  factory MarkItem.fromJson(Map<String, dynamic> json) => MarkItem(
    subject: json['subject'] as String,
    internal: (json['internal'] as num?)?.toDouble(),
    external: (json['external'] as num?)?.toDouble(),
    total: (json['total'] as num?)?.toDouble(),
    grade: json['grade'] as String?,
    cia1: (json['cia1'] as num?)?.toDouble(),
    cia2: (json['cia2'] as num?)?.toDouble(),
    cia3: (json['cia3'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'subject': subject,
    'internal': internal,
    'external': external,
    'total': total,
    'grade': grade,
    'cia1': cia1,
    'cia2': cia2,
    'cia3': cia3,
  };
}

class MarksCard {
  final int semester;
  final List<MarkItem> items;
  final double? sgpa;

  const MarksCard({
    required this.semester,
    required this.items,
    this.sgpa,
  });

  factory MarksCard.fromJson(Map<String, dynamic> json) => MarksCard(
    semester: json['semester'] as int,
    items: (json['items'] as List<dynamic>)
        .map((e) => MarkItem.fromJson(e as Map<String, dynamic>))
        .toList(),
    sgpa: (json['sgpa'] as num?)?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'semester': semester,
    'items': items.map((e) => e.toJson()).toList(),
    'sgpa': sgpa,
  };
}
