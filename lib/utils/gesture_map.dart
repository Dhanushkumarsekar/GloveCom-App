// Map<String, String> gestureToWord = {
//   "F1_HIGH_F2_LOW": "Hello",
//   "F1_LOW_F2_HIGH": "Thank you",
//   "ALL_LOW": "Goodbye",
//   "ALL_HIGH": "Yes",
// };



// import '../utils/gesture_map.dart'; // ✅ Keep this line active

// String? _recognizeGesture(Map<String, dynamic> data) {
//   // Convert data map to a simplified key
//   final f1 = data["f1"] ?? 0;
//   final f2 = data["f2"] ?? 0;

//   String pattern = "";
//   if (f1 > 800 && f2 < 400) pattern = "F1_HIGH_F2_LOW";
//   else if (f1 < 400 && f2 > 800) pattern = "F1_LOW_F2_HIGH";
//   else if (f1 < 300 && f2 < 300) pattern = "ALL_LOW";
//   else if (f1 > 900 && f2 > 900) pattern = "ALL_HIGH";

//   // ✅ Look up gesture from the map
//   if (gestureToWord.containsKey(pattern)) {
//     return gestureToWord[pattern];
//   }

//   return null;
// }


// lib/utils/gesture_map.dart
// Simple gesture map + recognition helper for GloveCom.
// Keep only mapping + helper functions here so imports are "used" and analyzer is happy.

/// Map from simplified pattern key -> displayed word/message.
final Map<String, String> gestureToWord = {
  "F1_HIGH_F2_LOW": "Hello",
  "F1_LOW_F2_HIGH": "Thank you",
  "ALL_LOW": "Yes",
  "ALL_HIGH": "No",
  // add more patterns as you train them
};

/// Safely convert a dynamic sensor value to int.
int _toInt(dynamic v) {
  if (v == null) return 0;
  if (v is int) return v;
  if (v is double) return v.toInt();
  final s = v.toString();
  return int.tryParse(s) ?? 0;
}

/// Try to recognize a gesture from a sensor data map.
///
/// The data map is expected to contain keys like f1, f2, x1, y1, F1, etc.
/// This function normalizes possible key names and returns a mapped word (e.g. "Hello")
/// if a pattern matches, otherwise returns null.
String? recognizeGestureFromData(Map<String, dynamic> data) {
  // Normalize and read a couple of likely keys (adjust to your ESP32 output)
  final int f1 = _toInt(data['f1'] ?? data['F1'] ?? data['x1'] ?? data['X1']);
  final int f2 = _toInt(data['f2'] ?? data['F2'] ?? data['y1'] ?? data['Y1']);

  // Build a simple pattern string using thresholds (tune these to your hardware)
  String pattern = '';

  if (f1 > 800 && f2 < 400) {
    pattern = 'F1_HIGH_F2_LOW';
  } else if (f1 < 400 && f2 > 800) {
    pattern = 'F1_LOW_F2_HIGH';
  } else if (f1 < 300 && f2 < 300) {
    pattern = 'ALL_LOW';
  } else if (f1 > 900 && f2 > 900) {
    pattern = 'ALL_HIGH';
  } else {
    // no pattern matched
    pattern = '';
  }

  if (pattern.isEmpty) {
    return null;
  }

  return gestureToWord[pattern];
}