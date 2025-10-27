// // // ignore_for_file: constant_identifier_names
// // import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// // /// =============================================================
// // /// 🧠 GLOVECOM APP CONSTANTS
// // /// Central place for all fixed values — BLE, Supabase, UI, etc.
// // /// =============================================================

// // // --------------------- BLE CONFIG -----------------------------

// // /// UUID of the BLE Service (must match ESP32 sketch)
// // const Guid BLE_SERVICE_UUID = Guid('4fafc201-1fb5-459e-8fcc-c5c9c331914b');

// // /// UUID of the BLE Characteristic (must match ESP32 sketch)
// // const Guid BLE_CHARACTERISTIC_UUID = Guid('beb5483e-36e1-4688-b7f5-ea07361b26a8');

// // /// Name your ESP32 device advertises over BLE
// // const String BLE_DEVICE_NAME = 'GloveCom-ESP32';

// // // -------------------- SUPABASE CONFIG --------------------------

// // /// Supabase table for storing trained gestures
// // const String SUPABASE_GESTURES_TABLE = 'gestures';

// // /// Supabase table for storing translation history
// // const String SUPABASE_HISTORY_TABLE = 'history';

// // // -------------------- APP CONFIG -------------------------------

// // /// Main app title
// // const String APP_TITLE = 'GloveCom';

// // /// Default data send interval (ESP32 side)
// // const int BLE_SEND_INTERVAL_MS = 500;

// // /// Timeout duration for BLE scan
// // const Duration BLE_SCAN_TIMEOUT = Duration(seconds: 5);

// // /// -------------------- TTS SETTINGS ----------------------------
// // /// (You can later use this if you integrate speech)
// // const String DEFAULT_VOICE_LANGUAGE = 'en-IN';
// // const double DEFAULT_VOICE_RATE = 0.9;
// // const double DEFAULT_VOICE_PITCH = 1.0;



// // ignore_for_file: constant_identifier_names
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// /// =============================================================
// /// 🧠 GLOVECOM APP CONSTANTS
// /// =============================================================

// // --------------------- BLE CONFIG -----------------------------
// const Guid BLE_SERVICE_UUID = Guid('847b6628-2150-4b77-b731-e557d04f8fec');
// const Guid BLE_CHARACTERISTIC_UUID = Guid('8c245332-9eba-48ce-b4b8-4483dec8f06b');
// const String BLE_DEVICE_NAME = 'GloveCom-ESP32';



// // -------------------- SUPABASE CONFIG --------------------------
// const String SUPABASE_GESTURES_TABLE = 'gestures';
// const String SUPABASE_HISTORY_TABLE = 'history';

// // -------------------- APP CONFIG -------------------------------
// const String APP_TITLE = 'GloveCom';
// const Duration BLE_SCAN_TIMEOUT = Duration(seconds: 5);
// const int BLE_SEND_INTERVAL_MS = 500;

// // -------------------- SPEECH SETTINGS --------------------------
// const String DEFAULT_VOICE_LANGUAGE = 'en-IN';
// const double DEFAULT_VOICE_RATE = 0.9;
// const double DEFAULT_VOICE_PITCH = 1.0;



// // ignore_for_file: constant_identifier_names
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// /// =============================================================
// /// 🧠 GLOVECOM APP CONSTANTS
// /// Central place for all fixed values — BLE, Supabase, UI, etc.
// /// =============================================================

// // --------------------- BLE CONFIG -----------------------------
// /// UUID of the BLE Service (must match your ESP32 sketch)
// const Guid BLE_SERVICE_UUID = Guid('847b6628-2150-4b77-b731-e557d04f8fec');

// /// UUID of the BLE Characteristic (must match your ESP32 sketch)
// const Guid BLE_CHARACTERISTIC_UUID = Guid('8c245332-9eba-48ce-b4b8-4483dec8f06b');

// /// Name your ESP32 device advertises over BLE
// const String BLE_DEVICE_NAME = 'GloveCom-ESP32';

// // -------------------- SUPABASE CONFIG --------------------------
// /// Supabase table for storing trained gestures
// const String SUPABASE_GESTURES_TABLE = 'gestures';

// /// Supabase table for storing translation history
// const String SUPABASE_HISTORY_TABLE = 'history';

// // -------------------- APP CONFIG -------------------------------
// /// Main app title
// const String APP_TITLE = 'GloveCom';

// /// Default data send interval (ESP32 side)
// const int BLE_SEND_INTERVAL_MS = 500;

// /// Timeout duration for BLE scan
// const Duration BLE_SCAN_TIMEOUT = Duration(seconds: 5);

// // -------------------- SPEECH SETTINGS --------------------------
// /// (You can later use this if you integrate speech)
// const String DEFAULT_VOICE_LANGUAGE = 'en-IN';
// const double DEFAULT_VOICE_RATE = 0.9;
// const double DEFAULT_VOICE_PITCH = 1.0;



// ignore_for_file: constant_identifier_names
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

/// =============================================================
/// 🧠 GLOVECOM APP CONSTANTS
/// =============================================================

// --------------------- BLE CONFIG -----------------------------
/// UUID of the BLE Service (must match your ESP32 sketch)
final Guid bleServiceUuid = Guid('847b6628-2150-4b77-b731-e557d04f8fec');
final Guid bleCharacteristicUuid = Guid('8c245332-9eba-48ce-b4b8-4483dec8f06b');



/// Name your ESP32 device advertises over BLE
const String BLE_DEVICE_NAME = 'GloveCom-ESP32';

// -------------------- SUPABASE CONFIG --------------------------
const String SUPABASE_GESTURES_TABLE = 'gestures';
const String SUPABASE_HISTORY_TABLE = 'history';

// -------------------- APP CONFIG -------------------------------
const String APP_TITLE = 'GloveCom';
const Duration BLE_SCAN_TIMEOUT = Duration(seconds: 5);
const int BLE_SEND_INTERVAL_MS = 500;

// -------------------- SPEECH SETTINGS --------------------------
const String DEFAULT_VOICE_LANGUAGE = 'en-IN';
const double DEFAULT_VOICE_RATE = 0.9;
const double DEFAULT_VOICE_PITCH = 1.0;
