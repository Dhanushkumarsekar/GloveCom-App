class HistoryModel {
  final String id;
  final String gestureName;
  final String translatedText;
  final DateTime timestamp;

  HistoryModel({
    required this.id,
    required this.gestureName,
    required this.translatedText,
    required this.timestamp,
  });

  factory HistoryModel.fromMap(Map<String, dynamic> m) => HistoryModel(
    id: m['id'] as String,
    gestureName: m['gesture_name'] as String? ?? '',
    translatedText: m['translated_text'] as String? ?? '',
    timestamp: DateTime.parse(m['timestamp'] as String? ?? DateTime.now().toIso8601String()),
  );
}
