class GestureModel {
  final String id;
  final String name;
  final Map<String, dynamic> pattern;
  final String? message;

  GestureModel({
    required this.id,
    required this.name,
    required this.pattern,
    this.message,
  });

  factory GestureModel.fromMap(Map<String, dynamic> m) => GestureModel(
    id: m['id'] as String,
    name: m['gesture_name'] as String,
    pattern: Map<String, dynamic>.from(m['esp32_pattern'] ?? {}),
    message: m['message'] as String?,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'gesture_name': name,
    'esp32_pattern': pattern,
    'message': message,
  };
}
