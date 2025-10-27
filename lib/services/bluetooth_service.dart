// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// class BluetoothService extends ChangeNotifier {
//   final FlutterBluePlus _flutterBlue = FlutterBluePlus.instance;
//   BluetoothDevice? connectedDevice;
//   Stream<List<int>>? deviceStream;
//   bool isScanning = false;

//   // start scan
//   void startScan() {
//     isScanning = true;
//     notifyListeners();
//     _flutterBlue.startScan(timeout: const Duration(seconds: 4));
//   }

//   void stopScan() {
//     _flutterBlue.stopScan();
//     isScanning = false;
//     notifyListeners();
//   }

//   Future<List<ScanResult>> scanResults() async {
//     return _flutterBlue.scanResults;
//   }

//   Future<void> connectToDevice(BluetoothDevice device) async {
//     await device.connect();
//     connectedDevice = device;
//     // discover services if needed
//     notifyListeners();
//   }

//   // parse incoming data: the device must expose a notify characteristic which we subscribe to.
//   // For simplicity this function is a stub — implement according to your ESP32 characteristic UUIDs.
//   Future<void> subscribeToCharacteristic(BluetoothDevice device, Guid serviceId, Guid charId) async {
//     final services = await device.discoverServices();
//     for (var s in services) {
//       if (s.uuid == serviceId.toString()) {
//         for (var c in s.characteristics) {
//           if (c.uuid == charId.toString()) {
//             await c.setNotifyValue(true);
//             c.value.listen((value) {
//               // value is bytes. Convert to string:
//               final str = String.fromCharCodes(value);
//               // You should parse incoming ESP32 message format here and notify UI
//               debugPrint('BLE RX: $str');
//               // TODO: parse and compare with gestures
//             });
//           }
//         }
//       }
//     }
//   }
// }



// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// class BluetoothService extends ChangeNotifier {
//   final FlutterBluePlus _flutterBlue = FlutterBluePlus();
//   BluetoothDevice? connectedDevice;
//   bool isScanning = false;

//   // Start scanning for BLE devices
//   Future<void> startScan() async {
//     if (isScanning) return;
//     isScanning = true;
//     notifyListeners();

//     await FlutterBluePlus.startScan(
//       timeout: const Duration(seconds: 4),
//       androidScanMode: AndroidScanMode.lowLatency,
//     );

//     // Stop scan automatically after timeout
//     FlutterBluePlus.isScanning.listen((scanning) {
//       isScanning = scanning;
//       notifyListeners();
//     });
//   }

//   // Stop scanning manually
//   Future<void> stopScan() async {
//     await FlutterBluePlus.stopScan();
//     isScanning = false;
//     notifyListeners();
//   }

//   // Return current scan results stream
//   Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

//   // Connect to a BLE device
//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect(autoConnect: false);
//       connectedDevice = device;
//       notifyListeners();
//       debugPrint('✅ Connected to ${device.platformName}');
//     } catch (e) {
//       debugPrint('❌ Connection error: $e');
//     }
//   }

//   // Disconnect from device
//   Future<void> disconnect() async {
//     await connectedDevice?.disconnect();
//     connectedDevice = null;
//     notifyListeners();
//   }

//   // Subscribe to a BLE characteristic for notifications
//   Future<void> subscribeToCharacteristic(
//       BluetoothDevice device, Guid serviceId, Guid charId) async {
//     final services = await device.discoverServices();

//     for (final s in services) {
//       if (s.uuid == serviceId) {
//         for (final c in s.characteristics) {
//           if (c.uuid == charId) {
//             await c.setNotifyValue(true);
//             // Listen to live data
//             c.lastValueStream.listen((value) {
//               final str = String.fromCharCodes(value);
//               debugPrint('📶 ESP32 → App: $str');
//               // TODO: Parse and match gesture here
//             });
//             debugPrint('✅ Subscribed to characteristic: ${c.uuid}');
//           }
//         }
//       }
//     }
//   }
// }




// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// class BluetoothService extends ChangeNotifier {
//   BluetoothDevice? connectedDevice;
//   bool isScanning = false;

//   // Start scanning for BLE devices
//   Future<void> startScan() async {
//     if (isScanning) return;
//     isScanning = true;
//     notifyListeners();

//     await FlutterBluePlus.startScan(
//       timeout: const Duration(seconds: 4),
//       androidScanMode: AndroidScanMode.lowLatency,
//     );

//     // Listen for scanning state
//     FlutterBluePlus.isScanning.listen((scanning) {
//       isScanning = scanning;
//       notifyListeners();
//     });
//   }

//   // Stop scanning manually
//   Future<void> stopScan() async {
//     await FlutterBluePlus.stopScan();
//     isScanning = false;
//     notifyListeners();
//   }

//   // Stream of currently discovered BLE devices
//   Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

//   // Connect to a BLE device
//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect(autoConnect: false);
//       connectedDevice = device;
//       notifyListeners();
//       debugPrint('✅ Connected to ${device.platformName}');
//     } catch (e) {
//       debugPrint('❌ Connection error: $e');
//     }
//   }

//   // Disconnect from the connected device
//   Future<void> disconnect() async {
//     await connectedDevice?.disconnect();
//     connectedDevice = null;
//     notifyListeners();
//   }

//   // Subscribe to the characteristic that sends ESP32 joystick data
//   Future<void> subscribeToCharacteristic(
//       BluetoothDevice device, Guid serviceId, Guid charId) async {
//     final services = await device.discoverServices();

//     for (final s in services) {
//       if (s.uuid == serviceId) {
//         for (final c in s.characteristics) {
//           if (c.uuid == charId) {
//             await c.setNotifyValue(true);
//             c.lastValueStream.listen((value) {
//               final data = String.fromCharCodes(value);
//               debugPrint('📶 ESP32 → App: $data');

//               // TODO: Parse data like "X1:512,Y1:300,..." and match with saved gesture
//             });
//             debugPrint('✅ Subscribed to ${c.uuid}');
//           }
//         }
//       }
//     }
//   }
// }



// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';

// class BluetoothService extends ChangeNotifier {
//   BluetoothDevice? connectedDevice;
//   BluetoothCharacteristic? notifyCharacteristic;
//   bool isScanning = false;
//   bool isConnected = false;

//   /// Stores latest joystick data string from ESP32, e.g. "X1:512,Y1:300,X2:700,Y2:520"
//   String latestJoystickData = "";

//   /// Start scanning for BLE devices
//   Future<void> startScan() async {
//     if (isScanning) return;
//     isScanning = true;
//     notifyListeners();

//     await FlutterBluePlus.startScan(
//       timeout: const Duration(seconds: 5),
//       androidScanMode: AndroidScanMode.lowLatency,
//     );

//     FlutterBluePlus.isScanning.listen((scanning) {
//       isScanning = scanning;
//       notifyListeners();
//     });
//   }

//   /// Stop scanning manually
//   Future<void> stopScan() async {
//     await FlutterBluePlus.stopScan();
//     isScanning = false;
//     notifyListeners();
//   }

//   /// Stream of discovered BLE devices
//   Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

//   /// Connect to a BLE device (your ESP32)
//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect(autoConnect: false);
//       connectedDevice = device;
//       isConnected = true;
//       notifyListeners();
//       debugPrint('✅ Connected to ${device.platformName}');
//     } catch (e) {
//       debugPrint('❌ Connection error: $e');
//     }
//   }

//   /// Disconnect from the current device
//   Future<void> disconnect() async {
//     try {
//       await connectedDevice?.disconnect();
//     } catch (_) {}
//     connectedDevice = null;
//     isConnected = false;
//     notifyListeners();
//   }

//   /// Subscribe to ESP32 characteristic that sends joystick data
//   /// You must replace [serviceId] and [charId] with your ESP32 BLE UUIDs.
//   Future<void> subscribeToCharacteristic(
//     BluetoothDevice device,
//     Guid serviceId,
//     Guid charId,
//   ) async {
//     try {
//       final services = await device.discoverServices();

//       for (final s in services) {
//         if (s.uuid == serviceId) {
//           for (final c in s.characteristics) {
//             if (c.uuid == charId) {
//               notifyCharacteristic = c;

//               await c.setNotifyValue(true);
//               c.lastValueStream.listen((value) {
//                 if (value.isNotEmpty) {
//                   final data = String.fromCharCodes(value);
//                   latestJoystickData = data;
//                   debugPrint('📶 ESP32 → App: $data');
//                   notifyListeners();
//                 }
//               });

//               debugPrint('✅ Subscribed to joystick characteristic: ${c.uuid}');
//               return;
//             }
//           }
//         }
//       }

//       debugPrint('⚠️ No matching service/characteristic found for ESP32');
//     } catch (e) {
//       debugPrint('❌ Error subscribing to characteristic: $e');
//     }
//   }

//   /// Helper: Parse latest joystick data into a Map for gesture matching
//   Map<String, dynamic> parseJoystickData() {
//     final Map<String, dynamic> result = {};
//     if (latestJoystickData.isEmpty) return result;

//     try {
//       final parts = latestJoystickData.split(',');
//       for (final part in parts) {
//         final kv = part.split(':');
//         if (kv.length == 2) {
//           result[kv[0].trim().toLowerCase()] = int.tryParse(kv[1]) ?? 0;
//         }
//       }
//     } catch (e) {
//       debugPrint('⚠️ Failed to parse joystick data: $e');
//     }

//     return result;
//   }
// }


// 


// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import '../constants.dart';

// class BluetoothService extends ChangeNotifier {
//   BluetoothDevice? connectedDevice;
//   BluetoothCharacteristic? notifyCharacteristic;
//   bool isScanning = false;
//   bool isConnected = false;

//   String latestJoystickData = "";
//   final StreamController<Map<String, dynamic>> _joystickController =
//       StreamController<Map<String, dynamic>>.broadcast();

//   Stream<Map<String, dynamic>> get joystickStream => _joystickController.stream;

//   Future<void> startScan() async {
//     if (isScanning) return;
//     isScanning = true;
//     notifyListeners();

//     await FlutterBluePlus.startScan(
//       timeout: BLE_SCAN_TIMEOUT,
//       androidScanMode: AndroidScanMode.lowLatency,
//     );

//     FlutterBluePlus.isScanning.listen((scanning) {
//       isScanning = scanning;
//       notifyListeners();
//     });
//   }

//   Future<void> stopScan() async {
//     await FlutterBluePlus.stopScan();
//     isScanning = false;
//     notifyListeners();
//   }

//   Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect(autoConnect: false);
//       connectedDevice = device;
//       isConnected = true;
//       notifyListeners();
//       debugPrint('✅ Connected to ${device.platformName}');
//     } catch (e) {
//       debugPrint('❌ Connection error: $e');
//     }
//   }

//   Future<void> disconnect() async {
//     try {
//       await connectedDevice?.disconnect();
//     } catch (_) {}
//     connectedDevice = null;
//     isConnected = false;
//     notifyListeners();
//   }

//   Future<void> subscribeToCharacteristic() async {
//     if (connectedDevice == null) {
//       debugPrint('⚠️ No device connected');
//       return;
//     }

//     try {
//       final services = await connectedDevice!.discoverServices();
//       for (final s in services) {
//         if (s.uuid == bleServiceUuid) {
//           for (final c in s.characteristics) {
//             if (c.uuid == bleCharacteristicUuid) {
//               notifyCharacteristic = c;
//               await c.setNotifyValue(true);

//               c.lastValueStream.listen((value) {
//                 if (value.isNotEmpty) {
//                   final data = String.fromCharCodes(value).trim();
//                   latestJoystickData = data;
//                   final parsed = _parseJoystickData(data);
//                   _joystickController.add(parsed);
//                   debugPrint('📶 ESP32 → App: $data');
//                   notifyListeners();
//                 }
//               });

//               debugPrint('✅ Subscribed to characteristic: ${c.uuid}');
//               return;
//             }
//           }
//         }
//       }
//       debugPrint('⚠️ No matching BLE characteristic found');
//     } catch (e) {
//       debugPrint('❌ Error subscribing: $e');
//     }
//   }

//   Map<String, dynamic> _parseJoystickData(String data) {
//     final Map<String, dynamic> result = {};
//     try {
//       final parts = data.split(',');
//       for (final part in parts) {
//         final kv = part.split(':');
//         if (kv.length == 2) {
//           final key = kv[0].trim().toLowerCase();
//           final val = int.tryParse(kv[1].trim());
//           if (val != null) result[key] = val;
//         }
//       }
//     } catch (e) {
//       debugPrint('⚠️ Parse error: $e');
//     }
//     return result;
//   }

//   @override
//   void dispose() {
//     _joystickController.close();
//     super.dispose();
//   }
// }



// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import '../constants.dart';

// class BluetoothService extends ChangeNotifier {
//   BluetoothDevice? connectedDevice;
//   BluetoothCharacteristic? notifyCharacteristic;
//   bool isScanning = false;
//   bool isConnected = false;

//   String latestJoystickData = "";
//   final StreamController<Map<String, dynamic>> _joystickController =
//       StreamController<Map<String, dynamic>>.broadcast();

//   Stream<Map<String, dynamic>> get joystickStream => _joystickController.stream;

//   Future<void> startScan() async {
//     if (isScanning) return;
//     isScanning = true;
//     notifyListeners();

//     await FlutterBluePlus.startScan(
//       timeout: BLE_SCAN_TIMEOUT,
//       androidScanMode: AndroidScanMode.lowLatency,
//     );

//     FlutterBluePlus.isScanning.listen((scanning) {
//       isScanning = scanning;
//       notifyListeners();
//     });
//   }

//   Future<void> stopScan() async {
//     await FlutterBluePlus.stopScan();
//     isScanning = false;
//     notifyListeners();
//   }

//   Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

//   /// ✅ Works with flutter_blue_plus v2.0.0-beta (license required)
//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect(
//         autoConnect: false,
//         timeout: const Duration(seconds: 35),
//         license: License(
//           organization: "GloveCom", // any string identifying your org/app
//           key: "FREE-LICENSE-1234", // arbitrary unique key
//         ),
//       );

//       connectedDevice = device;
//       isConnected = true;
//       notifyListeners();
//       debugPrint('✅ Connected to ${device.platformName}');
//     } catch (e) {
//       debugPrint('❌ Connection error: $e');
//     }
//   }

//   Future<void> disconnect() async {
//     try {
//       await connectedDevice?.disconnect();
//     } catch (_) {}
//     connectedDevice = null;
//     isConnected = false;
//     notifyListeners();
//   }

//   Future<void> subscribeToCharacteristic() async {
//     if (connectedDevice == null) {
//       debugPrint('⚠️ No device connected');
//       return;
//     }

//     try {
//       final services = await connectedDevice!.discoverServices();
//       for (final s in services) {
//         if (s.uuid == BLE_SERVICE_UUID) {
//           for (final c in s.characteristics) {
//             if (c.uuid == BLE_CHARACTERISTIC_UUID) {
//               notifyCharacteristic = c;
//               await c.setNotifyValue(true);

//               c.lastValueStream.listen((value) {
//                 if (value.isNotEmpty) {
//                   final data = String.fromCharCodes(value).trim();
//                   latestJoystickData = data;
//                   final parsed = _parseJoystickData(data);
//                   _joystickController.add(parsed);
//                   debugPrint('📶 ESP32 → App: $data');
//                   notifyListeners();
//                 }
//               });

//               debugPrint('✅ Subscribed to characteristic: ${c.uuid}');
//               return;
//             }
//           }
//         }
//       }
//       debugPrint('⚠️ No matching BLE characteristic found');
//     } catch (e) {
//       debugPrint('❌ Error subscribing: $e');
//     }
//   }

//   Map<String, dynamic> _parseJoystickData(String data) {
//     final Map<String, dynamic> result = {};
//     try {
//       final parts = data.split(',');
//       for (final part in parts) {
//         final kv = part.split(':');
//         if (kv.length == 2) {
//           final key = kv[0].trim().toLowerCase();
//           final val = int.tryParse(kv[1].trim());
//           if (val != null) result[key] = val;
//         }
//       }
//     } catch (e) {
//       debugPrint('⚠️ Parse error: $e');
//     }
//     return result;
//   }

//   @override
//   void dispose() {
//     _joystickController.close();
//     super.dispose();
//   }
// }


// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus_license.dart'; // ✅ Add this import
// import '../constants.dart';

// class BluetoothService extends ChangeNotifier {
//   BluetoothDevice? connectedDevice;
//   BluetoothCharacteristic? notifyCharacteristic;
//   bool isScanning = false;
//   bool isConnected = false;

//   String latestJoystickData = "";
//   final StreamController<Map<String, dynamic>> _joystickController =
//       StreamController<Map<String, dynamic>>.broadcast();

//   Stream<Map<String, dynamic>> get joystickStream => _joystickController.stream;

//   Future<void> startScan() async {
//     if (isScanning) return;
//     isScanning = true;
//     notifyListeners();

//     await FlutterBluePlus.startScan(
//       timeout: BLE_SCAN_TIMEOUT,
//       androidScanMode: AndroidScanMode.lowLatency,
//     );

//     FlutterBluePlus.isScanning.listen((scanning) {
//       isScanning = scanning;
//       notifyListeners();
//     });
//   }

//   Future<void> stopScan() async {
//     await FlutterBluePlus.stopScan();
//     isScanning = false;
//     notifyListeners();
//   }

//   Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

//   /// ✅ Works with flutter_blue_plus beta (license required)
//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect(
//         autoConnect: false,
//         timeout: const Duration(seconds: 35),
//         license: License(
//           organization: "GloveCom", // any string for your project
//           key: "FREE-LICENSE-1234", // arbitrary unique string
//         ),
//       );

//       connectedDevice = device;
//       isConnected = true;
//       notifyListeners();
//       debugPrint('✅ Connected to ${device.platformName}');
//     } catch (e) {
//       debugPrint('❌ Connection error: $e');
//     }
//   }

//   Future<void> disconnect() async {
//     try {
//       await connectedDevice?.disconnect();
//     } catch (_) {}
//     connectedDevice = null;
//     isConnected = false;
//     notifyListeners();
//   }

//   Future<void> subscribeToCharacteristic() async {
//     if (connectedDevice == null) {
//       debugPrint('⚠️ No device connected');
//       return;
//     }

//     try {
//       final services = await connectedDevice!.discoverServices();
//       for (final s in services) {
//         if (s.uuid == BLE_SERVICE_UUID) {
//           for (final c in s.characteristics) {
//             if (c.uuid == BLE_CHARACTERISTIC_UUID) {
//               notifyCharacteristic = c;
//               await c.setNotifyValue(true);

//               c.lastValueStream.listen((value) {
//                 if (value.isNotEmpty) {
//                   final data = String.fromCharCodes(value).trim();
//                   latestJoystickData = data;
//                   final parsed = _parseJoystickData(data);
//                   _joystickController.add(parsed);
//                   debugPrint('📶 ESP32 → App: $data');
//                   notifyListeners();
//                 }
//               });

//               debugPrint('✅ Subscribed to characteristic: ${c.uuid}');
//               return;
//             }
//           }
//         }
//       }
//       debugPrint('⚠️ No matching BLE characteristic found');
//     } catch (e) {
//       debugPrint('❌ Error subscribing: $e');
//     }
//   }

//   Map<String, dynamic> _parseJoystickData(String data) {
//     final Map<String, dynamic> result = {};
//     try {
//       final parts = data.split(',');
//       for (final part in parts) {
//         final kv = part.split(':');
//         if (kv.length == 2) {
//           final key = kv[0].trim().toLowerCase();
//           final val = int.tryParse(kv[1].trim());
//           if (val != null) result[key] = val;
//         }
//       }
//     } catch (e) {
//       debugPrint('⚠️ Parse error: $e');
//     }
//     return result;
//   }

//   @override
//   void dispose() {
//     _joystickController.close();
//     super.dispose();
//   }
// }



// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import '../utils/license_stub.dart';
//  // ✅ Required for License API
// import '../constants.dart';


// // import 'dart:async';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp; // ✅ Give alias "fbp"
// // import '../utils/license_stub.dart' show License; // ✅ Only import License from stub
// // import '../constants.dart';


// class BluetoothService extends ChangeNotifier {
//   BluetoothDevice? connectedDevice;
//   BluetoothCharacteristic? notifyCharacteristic;
//   bool isScanning = false;
//   bool isConnected = false;

//   String latestJoystickData = "";
//   final StreamController<Map<String, dynamic>> _joystickController =
//       StreamController<Map<String, dynamic>>.broadcast();

//   Stream<Map<String, dynamic>> get joystickStream => _joystickController.stream;

//   /// 🔍 Start scanning for BLE devices
//   Future<void> startScan() async {
//     if (isScanning) return;
//     isScanning = true;
//     notifyListeners();

//     await FlutterBluePlus.startScan(
//       timeout: BLE_SCAN_TIMEOUT,
//       androidScanMode: AndroidScanMode.lowLatency,
//     );

//     FlutterBluePlus.isScanning.listen((scanning) {
//       isScanning = scanning;
//       notifyListeners();
//     });
//   }

//   /// 🛑 Stop scanning
//   Future<void> stopScan() async {
//     await FlutterBluePlus.stopScan();
//     isScanning = false;
//     notifyListeners();
//   }

//   /// 📡 Stream of scan results
//   Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

//   /// ✅ Connect to a BLE device (License required in flutter_blue_plus 2.0.0-beta)
//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect(
//   autoConnect: false,
//   timeout: const Duration(seconds: 35),
//   license: const fbp.License(
//     organization: "GloveCom",
//     key: "FREE-LICENSE-1234",
//   ),
// );



//       connectedDevice = device;
//       isConnected = true;
//       notifyListeners();
//       debugPrint('✅ Connected to ${device.platformName}');
//     } catch (e) {
//       debugPrint('❌ Connection error: $e');
//     }
//   }

//   /// 🔌 Disconnect from device
//   Future<void> disconnect() async {
//     try {
//       await connectedDevice?.disconnect();
//     } catch (_) {}
//     connectedDevice = null;
//     isConnected = false;
//     notifyListeners();
//   }

//   /// 📶 Subscribe to the BLE characteristic for live data updates
//   Future<void> subscribeToCharacteristic() async {
//     if (connectedDevice == null) {
//       debugPrint('⚠️ No device connected');
//       return;
//     }

//     try {
//       final services = await connectedDevice!.discoverServices();
//       for (final s in services) {
//         if (s.uuid == bleServiceUuid) {
//           for (final c in s.characteristics) {
//             if (c.uuid == bleCharacteristicUuid) {
//               notifyCharacteristic = c;
//               await c.setNotifyValue(true);

//               c.lastValueStream.listen((value) {
//                 if (value.isNotEmpty) {
//                   final data = String.fromCharCodes(value).trim();
//                   latestJoystickData = data;
//                   final parsed = _parseJoystickData(data);
//                   _joystickController.add(parsed);
//                   debugPrint('📶 ESP32 → App: $data');
//                   notifyListeners();
//                 }
//               });

//               debugPrint('✅ Subscribed to characteristic: ${c.uuid}');
//               return;
//             }
//           }
//         }
//       }
//       debugPrint('⚠️ No matching BLE characteristic found');
//     } catch (e) {
//       debugPrint('❌ Error subscribing: $e');
//     }
//   }

//   /// 🧠 Helper to parse joystick data (e.g., "x1:512,y1:300,x2:700")
//   Map<String, dynamic> _parseJoystickData(String data) {
//     final Map<String, dynamic> result = {};
//     try {
//       final parts = data.split(',');
//       for (final part in parts) {
//         final kv = part.split(':');
//         if (kv.length == 2) {
//           final key = kv[0].trim().toLowerCase();
//           final val = int.tryParse(kv[1].trim());
//           if (val != null) result[key] = val;
//         }
//       }
//     } catch (e) {
//       debugPrint('⚠️ Parse error: $e');
//     }
//     return result;
//   }

//   @override
//   void dispose() {
//     _joystickController.close();
//     super.dispose();
//   }
// }





// // import 'dart:async';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// // import '../constants.dart';



// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// // import '../utils/flutter_blue_plus_license.dart';

// // import 'package:flutter_blue_plus/flutter_blue_plus_license.dart'; // ✅ important
// import '../constants.dart';

// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import '../utils/flutter_blue_plus_license.dart'; // ✅ Use our custom class
// import '../constants.dart';

// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart' ; // ✅ give prefix
// import '../utils/flutter_blue_plus_license.dart' as custom;        // ✅ separate prefix
// import '../constants.dart';


// class BluetoothService extends ChangeNotifier {
//   BluetoothDevice? connectedDevice;
//   BluetoothCharacteristic? notifyCharacteristic;
//   bool isScanning = false;
//   bool isConnected = false;

//   String latestJoystickData = "";
//   final StreamController<Map<String, dynamic>> _joystickController =
//       StreamController<Map<String, dynamic>>.broadcast();

//   Stream<Map<String, dynamic>> get joystickStream => _joystickController.stream;

//   /// 🔍 Start scanning for BLE devices
//   Future<void> startScan() async {
//     if (isScanning) return;
//     isScanning = true;
//     notifyListeners();

//     await FlutterBluePlus.startScan(
//       timeout: BLE_SCAN_TIMEOUT,
//       androidScanMode: AndroidScanMode.lowLatency,
//     );

//     FlutterBluePlus.isScanning.listen((scanning) {
//       isScanning = scanning;
//       notifyListeners();
//     });
//   }

//   /// 🛑 Stop scanning
//   Future<void> stopScan() async {
//     await FlutterBluePlus.stopScan();
//     isScanning = false;
//     notifyListeners();
//   }

//   /// 📡 Stream of scan results
//   Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

//   /// ✅ Connect to a BLE device (NO license parameter in stable build)
//   Future<void> connectToDevice(fbp.BluetoothDevice device) async {
//   try {
//     await device.connect(
//       autoConnect: false,
//       timeout: const Duration(seconds: 35),
//       license: const custom.License(
//         organization: "GloveCom",
//         key: "FREE-LICENSE-1234",
//       ),
//     );

//     connectedDevice = device;
//     isConnected = true;
//     notifyListeners();
//     debugPrint('✅ Connected to ${device.platformName}');
//   } catch (e) {
//     debugPrint('❌ Connection error: $e');
//   }
// }


//   /// 🔌 Disconnect from device
//   Future<void> disconnect() async {
//     try {
//       await connectedDevice?.disconnect();
//     } catch (_) {}
//     connectedDevice = null;
//     isConnected = false;
//     notifyListeners();
//   }

//   /// 📶 Subscribe to the BLE characteristic for live data updates
//   Future<void> subscribeToCharacteristic() async {
//     if (connectedDevice == null) {
//       debugPrint('⚠️ No device connected');
//       return;
//     }

//     try {
//       final services = await connectedDevice!.discoverServices();
//       for (final s in services) {
//         if (s.uuid == bleServiceUuid) {
//           for (final c in s.characteristics) {
//             if (c.uuid == bleCharacteristicUuid) {
//               notifyCharacteristic = c;
//               await c.setNotifyValue(true);

//               c.lastValueStream.listen((value) {
//                 if (value.isNotEmpty) {
//                   final data = String.fromCharCodes(value).trim();
//                   latestJoystickData = data;
//                   final parsed = _parseJoystickData(data);
//                   _joystickController.add(parsed);
//                   debugPrint('📶 ESP32 → App: $data');
//                   notifyListeners();
//                 }
//               });

//               debugPrint('✅ Subscribed to characteristic: ${c.uuid}');
//               return;
//             }
//           }
//         }
//       }
//       debugPrint('⚠️ No matching BLE characteristic found');
//     } catch (e) {
//       debugPrint('❌ Error subscribing: $e');
//     }
//   }

//   /// 🧠 Helper to parse joystick data (e.g., "x1:512,y1:300,x2:700")
//   Map<String, dynamic> _parseJoystickData(String data) {
//     final Map<String, dynamic> result = {};
//     try {
//       final parts = data.split(',');
//       for (final part in parts) {
//         final kv = part.split(':');
//         if (kv.length == 2) {
//           final key = kv[0].trim().toLowerCase();
//           final val = int.tryParse(kv[1].trim());
//           if (val != null) result[key] = val;
//         }
//       }
//     } catch (e) {
//       debugPrint('⚠️ Parse error: $e');
//     }
//     return result;
//   }

//   @override
//   void dispose() {
//     _joystickController.close();
//     super.dispose();
//   }
// }



// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp; // ✅ Prefix for clarity
// import '../utils/flutter_blue_plus_license.dart' as custom;        // ✅ Separate prefix
// import '../constants.dart';


// // import 'dart:async';
// // import 'package:flutter/foundation.dart';
// // import 'package:flutter_blue_plus/flutter_blue_plus.dart'; // ✅ No aliases needed anymore
// // import '../constants.dart';


// class BluetoothService extends ChangeNotifier {
//   fbp.BluetoothDevice? connectedDevice;
//   fbp.BluetoothCharacteristic? notifyCharacteristic;
//   bool isScanning = false;
//   bool isConnected = false;

//   String latestJoystickData = "";
//   final StreamController<Map<String, dynamic>> _joystickController =
//       StreamController<Map<String, dynamic>>.broadcast();

//   Stream<Map<String, dynamic>> get joystickStream => _joystickController.stream;

//   /// 🔍 Start scanning for BLE devices
//   Future<void> startScan() async {
//     if (isScanning) return;
//     isScanning = true;
//     notifyListeners();

//     await fbp.FlutterBluePlus.startScan(
//       timeout: BLE_SCAN_TIMEOUT,
//       androidScanMode: fbp.AndroidScanMode.lowLatency,
//     );

//     fbp.FlutterBluePlus.isScanning.listen((scanning) {
//       isScanning = scanning;
//       notifyListeners();
//     });
//   }

//   /// 🛑 Stop scanning
//   Future<void> stopScan() async {
//     await fbp.FlutterBluePlus.stopScan();
//     isScanning = false;
//     notifyListeners();
//   }

//   /// 📡 Stream of scan results
//   Stream<List<fbp.ScanResult>> get scanResults => fbp.FlutterBluePlus.scanResults;

//   /// ✅ Connect to a BLE device
//   Future<void> connectToDevice(fbp.BluetoothDevice device) async {
//     try {
//       await device.connect(
//         autoConnect: false,
//         timeout: const Duration(seconds: 35),
//         license: const custom.License(
//           organization: "GloveCom",
//           key: "FREE-LICENSE-1234",
//         ),
//       );

//       connectedDevice = device;
//       isConnected = true;
//       notifyListeners();
//       debugPrint('✅ Connected to ${device.platformName}');
//     } catch (e) {
//       debugPrint('❌ Connection error: $e');
//     }
//   }

//   /// 🔌 Disconnect from device
//   Future<void> disconnect() async {
//     try {
//       await connectedDevice?.disconnect();
//     } catch (_) {}
//     connectedDevice = null;
//     isConnected = false;
//     notifyListeners();
//   }

//   /// 📶 Subscribe to the BLE characteristic for live data updates
//   Future<void> subscribeToCharacteristic() async {
//     if (connectedDevice == null) {
//       debugPrint('⚠️ No device connected');
//       return;
//     }

//     try {
//       final services = await connectedDevice!.discoverServices();
//       for (final s in services) {
//         if (s.uuid == bleServiceUuid) {
//           for (final c in s.characteristics) {
//             if (c.uuid == bleCharacteristicUuid) {
//               notifyCharacteristic = c;
//               await c.setNotifyValue(true);

//               c.lastValueStream.listen((value) {
//                 if (value.isNotEmpty) {
//                   final data = String.fromCharCodes(value).trim();
//                   latestJoystickData = data;
//                   final parsed = _parseJoystickData(data);
//                   _joystickController.add(parsed);
//                   debugPrint('📶 ESP32 → App: $data');
//                   notifyListeners();
//                 }
//               });

//               debugPrint('✅ Subscribed to characteristic: ${c.uuid}');
//               return;
//             }
//           }
//         }
//       }
//       debugPrint('⚠️ No matching BLE characteristic found');
//     } catch (e) {
//       debugPrint('❌ Error subscribing: $e');
//     }
//   }

//   /// 🧠 Helper to parse joystick data (e.g., "x1:512,y1:300,x2:700")
//   Map<String, dynamic> _parseJoystickData(String data) {
//     final Map<String, dynamic> result = {};
//     try {
//       final parts = data.split(',');
//       for (final part in parts) {
//         final kv = part.split(':');
//         if (kv.length == 2) {
//           final key = kv[0].trim().toLowerCase();
//           final val = int.tryParse(kv[1].trim());
//           if (val != null) result[key] = val;
//         }
//       }
//     } catch (e) {
//       debugPrint('⚠️ Parse error: $e');
//     }
//     return result;
//   }

//   @override
//   void dispose() {
//     _joystickController.close();
//     super.dispose();
//   }
// }



// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import '../constants.dart';

// class BluetoothService extends ChangeNotifier {
//   BluetoothDevice? connectedDevice;
//   BluetoothCharacteristic? notifyCharacteristic;
//   bool isScanning = false;
//   bool isConnected = false;

//   String latestJoystickData = "";
//   final StreamController<Map<String, dynamic>> _joystickController =
//       StreamController<Map<String, dynamic>>.broadcast();

//   Stream<Map<String, dynamic>> get joystickStream => _joystickController.stream;

//   /// 🔍 Start scanning for BLE devices
//   Future<void> startScan() async {
//     if (isScanning) return;
//     isScanning = true;
//     notifyListeners();

//     await FlutterBluePlus.startScan(
//       timeout: BLE_SCAN_TIMEOUT,
//       androidScanMode: AndroidScanMode.lowLatency,
//     );

//     FlutterBluePlus.isScanning.listen((scanning) {
//       isScanning = scanning;
//       notifyListeners();
//     });
//   }

//   /// 🛑 Stop scanning
//   Future<void> stopScan() async {
//     await FlutterBluePlus.stopScan();
//     isScanning = false;
//     notifyListeners();
//   }

//   /// 📡 Stream of scan results
//   Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

//   /// ✅ Connect to a BLE device (with License support)
//  Future<void> connectToDevice(BluetoothDevice device) async {
//   try {
//     await device.connect(
//       autoConnect: false,
//       timeout: const Duration(seconds: 35),
//       license: License.acknowledged, // ✅ Correct replacement
//     );

//     connectedDevice = device;
//     isConnected = true;
//     notifyListeners();
//     debugPrint('✅ Connected to ${device.platformName}');
//   } catch (e) {
//     debugPrint('❌ Connection error: $e');
//   }
// }


//   /// 🔌 Disconnect from device
//   Future<void> disconnect() async {
//     try {
//       await connectedDevice?.disconnect();
//     } catch (_) {}
//     connectedDevice = null;
//     isConnected = false;
//     notifyListeners();
//   }

//   /// 📶 Subscribe to BLE data
//   Future<void> subscribeToCharacteristic() async {
//     if (connectedDevice == null) {
//       debugPrint('⚠️ No device connected');
//       return;
//     }

//     try {
//       final services = await connectedDevice!.discoverServices();
//       for (final s in services) {
//         if (s.uuid == bleServiceUuid) {
//           for (final c in s.characteristics) {
//             if (c.uuid == bleCharacteristicUuid) {
//               notifyCharacteristic = c;
//               await c.setNotifyValue(true);

//               c.lastValueStream.listen((value) {
//                 if (value.isNotEmpty) {
//                   final data = String.fromCharCodes(value).trim();
//                   latestJoystickData = data;
//                   final parsed = _parseJoystickData(data);
//                   _joystickController.add(parsed);
//                   debugPrint('📶 ESP32 → App: $data');
//                   notifyListeners();
//                 }
//               });

//               debugPrint('✅ Subscribed to characteristic: ${c.uuid}');
//               return;
//             }
//           }
//         }
//       }
//       debugPrint('⚠️ No matching BLE characteristic found');
//     } catch (e) {
//       debugPrint('❌ Error subscribing: $e');
//     }
//   }

//   /// 🧠 Parse joystick data
//   Map<String, dynamic> _parseJoystickData(String data) {
//     final Map<String, dynamic> result = {};
//     try {
//       final parts = data.split(',');
//       for (final part in parts) {
//         final kv = part.split(':');
//         if (kv.length == 2) {
//           final key = kv[0].trim().toLowerCase();
//           final val = int.tryParse(kv[1].trim());
//           if (val != null) result[key] = val;
//         }
//       }
//     } catch (e) {
//       debugPrint('⚠️ Parse error: $e');
//     }
//     return result;
//   }

//   @override
//   void dispose() {
//     _joystickController.close();
//     super.dispose();
//   }
// }



// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import '../constants.dart';

// class BluetoothService extends ChangeNotifier {
//   BluetoothDevice? connectedDevice;
//   BluetoothCharacteristic? notifyCharacteristic;
//   bool isScanning = false;
//   bool isConnected = false;

//   String latestJoystickData = "";
//   final StreamController<Map<String, dynamic>> _joystickController =
//       StreamController<Map<String, dynamic>>.broadcast();

//   Stream<Map<String, dynamic>> get joystickStream => _joystickController.stream;

//   /// 🔍 Start scanning for BLE devices
//   Future<void> startScan() async {
//     if (isScanning) return;
//     isScanning = true;
//     notifyListeners();

//     // startScan is a static method on FlutterBluePlus
//     await FlutterBluePlus.startScan(
//       timeout: BLE_SCAN_TIMEOUT,
//       androidScanMode: AndroidScanMode.lowLatency,
//     );

//     // keep UI in sync with scanning state
//     FlutterBluePlus.isScanning.listen((scanning) {
//       isScanning = scanning;
//       notifyListeners();
//     });
//   }

//   /// 🛑 Stop scanning
//   Future<void> stopScan() async {
//     await FlutterBluePlus.stopScan();
//     isScanning = false;
//     notifyListeners();
//   }

//   /// 📡 Stream of scan results (list of ScanResult)
//   Stream<List<ScanResult>> get scanResults => FlutterBluePlus.scanResults;

//   /// ✅ Connect to a BLE device
//   ///
//   /// NOTE: stable flutter_blue_plus releases expect a `License` object
//   /// constructed with organization/key. If your installed package version
//   /// requires a different form (like `License.acknowledged`), swap that here.
//  Future<void> connectToDevice(BluetoothDevice device) async {
//   try {
//     await device.connect(
//       autoConnect: false,
//       timeout: const Duration(seconds: 35),
//       license: License(
//         organization: "GloveCom",
//         key: "FREE-LICENSE-1234",
//       ),
//     );

//     connectedDevice = device;
//     isConnected = true;
//     notifyListeners();
//     debugPrint('✅ Connected to ${device.platformName}');
//   } catch (e) {
//     debugPrint('❌ Connection error: $e');
//   }
// }


//   /// 🔌 Disconnect from device
//   Future<void> disconnect() async {
//     try {
//       await connectedDevice?.disconnect();
//     } catch (e) {
//       debugPrint('⚠️ Error while disconnecting: $e');
//     }
//     connectedDevice = null;
//     isConnected = false;
//     notifyListeners();
//   }

//   /// 📶 Subscribe to the BLE characteristic for live data updates
//   Future<void> subscribeToCharacteristic() async {
//     if (connectedDevice == null) {
//       debugPrint('⚠️ No device connected');
//       return;
//     }

//     try {
//       final services = await connectedDevice!.discoverServices();
//       for (final s in services) {
//         // Compare using the Guid constants in constants.dart
//         if (s.uuid == bleServiceUuid) {
//           for (final c in s.characteristics) {
//             if (c.uuid == bleCharacteristicUuid) {
//               notifyCharacteristic = c;

//               // enable notifications
//               await c.setNotifyValue(true);

//               // listen to value stream
//               c.lastValueStream.listen((value) {
//                 if (value.isNotEmpty) {
//                   final data = String.fromCharCodes(value).trim();
//                   latestJoystickData = data;
//                   final parsed = _parseJoystickData(data);
//                   _joystickController.add(parsed);
//                   debugPrint('📶 ESP32 → App: $data');
//                   notifyListeners();
//                 }
//               });

//               debugPrint('✅ Subscribed to characteristic: ${c.uuid}');
//               return;
//             }
//           }
//         }
//       }
//       debugPrint('⚠️ No matching BLE characteristic found (check UUIDs)');
//     } catch (e, st) {
//       debugPrint('❌ Error subscribing: $e\n$st');
//     }
//   }

//   /// Parse joystick data strings of the form:
//   /// "X1:512,Y1:300,X2:700,Y2:520,X3:400"
//   Map<String, dynamic> _parseJoystickData(String data) {
//     final Map<String, dynamic> result = {};
//     try {
//       final parts = data.split(',');
//       for (final part in parts) {
//         final kv = part.split(':');
//         if (kv.length == 2) {
//           final key = kv[0].trim().toLowerCase();
//           final val = int.tryParse(kv[1].trim());
//           if (val != null) result[key] = val;
//         }
//       }
//     } catch (e) {
//       debugPrint('⚠️ Parse error: $e');
//     }
//     return result;
//   }

//   @override
//   void dispose() {
//     _joystickController.close();
//     super.dispose();
//   }
// }




// 


import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart' as fbp;
import '../constants.dart';

class BluetoothService extends ChangeNotifier {
  fbp.BluetoothDevice? connectedDevice;
  fbp.BluetoothCharacteristic? notifyCharacteristic;
  bool isConnected = false;
  final FlutterTts flutterTts = FlutterTts();

  String receivedText = "";
  // ✅ Stream controller for sending gesture data to UI
final StreamController<String> _gestureStreamController = StreamController<String>.broadcast();

// Expose gesture stream to UI
Stream<String> get gestureStream => _gestureStreamController.stream;

  /// Start scanning for BLE devices
  Future<void> startScan() async {
    await fbp.FlutterBluePlus.startScan(
      timeout: const Duration(seconds: 10),
      androidScanMode: fbp.AndroidScanMode.lowLatency,
    );
  }

  /// Stop scanning
  Future<void> stopScan() async {
    await fbp.FlutterBluePlus.stopScan();
  }

  /// Stream of scan results
  Stream<List<fbp.ScanResult>> get scanResults => fbp.FlutterBluePlus.scanResults;

  /// Connect to a device
  Future<void> connectToDevice(fbp.BluetoothDevice device) async {
    try {
      await device.connect(autoConnect: false);
      connectedDevice = device;
      isConnected = true;
      notifyListeners();

      await _discoverServices();
    } catch (e) {
      debugPrint("❌ Connection error: $e");
    }
  }

  /// Discover services and subscribe to data
  Future<void> _discoverServices() async {
    if (connectedDevice == null) return;

    List<fbp.BluetoothService> services = await connectedDevice!.discoverServices();
    for (var s in services) {
      if (s.uuid == bleServiceUuid) {
        for (var c in s.characteristics) {
          if (c.uuid == bleCharacteristicUuid) {
            notifyCharacteristic = c;
            await c.setNotifyValue(true);
            c.lastValueStream.listen((data) async {
              if (data.isNotEmpty) {
                String text = String.fromCharCodes(data).trim();
                receivedText = text;
                notifyListeners();
                debugPrint("📩 Received: $text");

                // 🔊 Speak the received message
                await flutterTts.speak(text);
              }
            });
          }
        }
      }
    }
  }

  /// Disconnect device
  Future<void> disconnect() async {
    await connectedDevice?.disconnect();
    connectedDevice = null;
    isConnected = false;
    notifyListeners();
  }
}