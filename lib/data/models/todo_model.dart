class TodoModel {
  final String? id;
  final String title;
  final String description;
  final bool isCompleted;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['_id'] != null ? map['_id'] as String : null, // Fix Here
      title: map['title'] as String,
      description: map['description'] as String,
      isCompleted: map['is_completed'] as bool,
    );
  }

  factory TodoModel.fromJsonMap(Map<String, dynamic> map) {
    return TodoModel.fromMap(map);
  }
}