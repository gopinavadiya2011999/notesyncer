class Task {
  String id;
  String title;
  String description;
  DateTime updatedAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.updatedAt,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'updatedAt': updatedAt.toIso8601String(),
  };
}
