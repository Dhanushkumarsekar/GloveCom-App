// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../services/supabase_service.dart';
// import '../services/bluetooth_service.dart';

// class GestureTrainingScreen extends StatefulWidget {
//   const GestureTrainingScreen({super.key});

//   @override
//   State<GestureTrainingScreen> createState() => _GestureTrainingScreenState();
// }

// class _GestureTrainingScreenState extends State<GestureTrainingScreen> {
//   final _nameCtl = TextEditingController();
//   final _messageCtl = TextEditingController();
//   Map<String, dynamic> _samplePattern = {};

//   @override
//   void dispose() {
//     _nameCtl.dispose();
//     _messageCtl.dispose();
//     super.dispose();
//   }

//   // Simulate capture from ESP32 — in real app subscribe to BLE characteristic and capture values
//   void _captureSample() {
//     // Example pattern: joystick values
//     setState(() {
//       _samplePattern = {
//         'x1': 512,
//         'y1': 300,
//         'x2': 700,
//         'y2': 520,
//         'x3': 400
//       };
//     });
//   }

//   Future<void> _saveGesture() async {
//     final name = _nameCtl.text.trim();
//     final message = _messageCtl.text.trim();
//     if (name.isEmpty || _samplePattern.isEmpty) return;
//     final svc = SupabaseService.instance;
//     await svc.insertGesture({
//       'gesture_name': name,
//       'esp32_pattern': _samplePattern,
//       'message': message
//     });
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Gesture saved')));
//     _nameCtl.clear();
//     _messageCtl.clear();
//     setState(() { _samplePattern = {}; });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bt = Provider.of<BluetoothService>(context);
//     return Scaffold(
//       appBar: AppBar(title: const Text('Gesture Training')),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             TextField(controller: _nameCtl, decoration: const InputDecoration(labelText: 'Gesture name')),
//             TextField(controller: _messageCtl, decoration: const InputDecoration(labelText: 'Message to show/speak')),
//             const SizedBox(height: 12),
//             ElevatedButton(onPressed: _captureSample, child: const Text('Capture sample from ESP32 (simulate)')),
//             const SizedBox(height: 8),
//             if (_samplePattern.isNotEmpty) Text('Captured: ' + jsonEncode(_samplePattern)),
//             const SizedBox(height: 12),
//             ElevatedButton(onPressed: _saveGesture, child: const Text('Save Gesture')),
//             const SizedBox(height: 20),
//             const Text('Note: Replace capture logic with BLE subscription to characteristic in BluetoothService'),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:postgrest/postgrest.dart'; // for Supabase error handling
// import 'package:provider/provider.dart';
// import '../services/supabase_service.dart';
// import '../services/bluetooth_service.dart';

// class GestureTrainingScreen extends StatefulWidget {
//   const GestureTrainingScreen({super.key});

//   @override
//   State<GestureTrainingScreen> createState() => _GestureTrainingScreenState();
// }

// class _GestureTrainingScreenState extends State<GestureTrainingScreen> {
//   final _nameCtl = TextEditingController();
//   final _messageCtl = TextEditingController();
//   Map<String, dynamic> _samplePattern = {};
//   bool _isSaving = false;
//   bool _useSimulatedData = true; // toggle between simulation and BLE data

//   @override
//   void dispose() {
//     _nameCtl.dispose();
//     _messageCtl.dispose();
//     super.dispose();
//   }

//   /// Simulate capture from ESP32 (for testing without device)
//   void _captureSampleSimulated() {
//     setState(() {
//       _samplePattern = {
//         'x1': 512,
//         'y1': 300,
//         'x2': 700,
//         'y2': 520,
//         'x3': 400
//       };
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('🧪 Simulated data captured')),
//     );
//   }

//   /// Capture from BluetoothService (real ESP32 data)
//   void _captureSampleFromBLE() {
//     final bt = Provider.of<BluetoothService>(context, listen: false);

//     // Suppose BluetoothService has a property for latest data (you can add this)
//     // Example format received from ESP32: "X1:512,Y1:300,X2:700,Y2:520,X3:400"
//     // You can modify your BluetoothService to set this each time data is received.
//     const fakeExample = "X1:520,Y1:310,X2:710,Y2:530,X3:410"; // demo line

//     final pattern = _parseJoystickData(fakeExample);

//     setState(() {
//       _samplePattern = pattern;
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('📶 BLE sample captured')),
//     );
//   }

//   /// Parse incoming ESP32 joystick string into JSON format
//   Map<String, dynamic> _parseJoystickData(String data) {
//     final parts = data.split(',');
//     final Map<String, dynamic> result = {};
//     for (final part in parts) {
//       final kv = part.split(':');
//       if (kv.length == 2) {
//         result[kv[0].trim().toLowerCase()] = int.tryParse(kv[1]) ?? 0;
//       }
//     }
//     return result;
//   }

//   /// Save gesture to Supabase
//   Future<void> _saveGesture() async {
//     final name = _nameCtl.text.trim();
//     final message = _messageCtl.text.trim();

//     if (name.isEmpty || _samplePattern.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('⚠️ Please enter name and capture pattern')),
//       );
//       return;
//     }

//     setState(() => _isSaving = true);
//     final svc = SupabaseService.instance;

//     try {
//       await svc.insertGesture({
//         'gesture_name': name,
//         'esp32_pattern': _samplePattern,
//         'message': message,
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('✅ Gesture saved successfully')),
//       );

//       _nameCtl.clear();
//       _messageCtl.clear();
//       setState(() {
//         _samplePattern = {};
//         _isSaving = false;
//       });
//     } on PostgrestException catch (e) {
//       setState(() => _isSaving = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('❌ Supabase error: ${e.message}')),
//       );
//     } catch (e) {
//       setState(() => _isSaving = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('❌ Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Gesture Training'),
//         actions: [
//           Switch(
//             value: _useSimulatedData,
//             onChanged: (v) {
//               setState(() => _useSimulatedData = v);
//             },
//           ),
//           const Padding(
//             padding: EdgeInsets.only(right: 12),
//             child: Center(child: Text('Simulate')),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: _nameCtl,
//                 decoration: const InputDecoration(
//                   labelText: 'Gesture Name',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: _messageCtl,
//                 decoration: const InputDecoration(
//                   labelText: 'Message (Text/Speech)',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Capture Buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: _useSimulatedData
//                         ? _captureSampleSimulated
//                         : _captureSampleFromBLE,
//                     icon: const Icon(Icons.sensors),
//                     label: Text(_useSimulatedData
//                         ? 'Capture Simulated'
//                         : 'Capture from BLE'),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: _isSaving ? null : _saveGesture,
//                     icon: const Icon(Icons.save),
//                     label: const Text('Save Gesture'),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),

//               if (_samplePattern.isNotEmpty)
//                 Card(
//                   color: Colors.indigo.shade50,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Captured Pattern:\n${const JsonEncoder.withIndent("  ").convert(_samplePattern)}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ),

//               const SizedBox(height: 16),
//               const Divider(),
//               const Text(
//                 '💡 Tip: When using a real ESP32 glove, ensure it sends joystick values '
//                 'like "X1:512,Y1:300,X2:700,Y2:520,X3:400" over Bluetooth. The app will '
//                 'auto-parse and match it with stored gestures.',
//                 style: TextStyle(fontSize: 13),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:postgrest/postgrest.dart'; // for Supabase error handling
// import 'package:provider/provider.dart';
// import '../services/supabase_service.dart';
// import '../services/bluetooth_service.dart';

// class GestureTrainingScreen extends StatefulWidget {
//   const GestureTrainingScreen({super.key});

//   @override
//   State<GestureTrainingScreen> createState() => _GestureTrainingScreenState();
// }

// class _GestureTrainingScreenState extends State<GestureTrainingScreen> {
//   final _nameCtl = TextEditingController();
//   final _messageCtl = TextEditingController();
//   Map<String, dynamic> _samplePattern = {};
//   bool _isSaving = false;
//   bool _useSimulatedData = true; // toggle between simulation and BLE data

//   @override
//   void dispose() {
//     _nameCtl.dispose();
//     _messageCtl.dispose();
//     super.dispose();
//   }

//   /// Simulate capture from ESP32 (for testing without device)
//   void _captureSampleSimulated() {
//     setState(() {
//       _samplePattern = {
//         'x1': 512,
//         'y1': 300,
//         'x2': 700,
//         'y2': 520,
//         'x3': 400
//       };
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('🧪 Simulated data captured')),
//     );
//   }

//   /// Capture from BluetoothService (real ESP32 data)
//   void _captureSampleFromBLE() {
//     // Use Provider only here (listen: false) so we don't keep an unused local variable
//     final bt = Provider.of<BluetoothService>(context, listen: false);

//     final data = bt.latestJoystickData.trim();
//     if (data.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('⚠️ No BLE data received yet. Make sure device is connected and sending data.')),
//       );
//       return;
//     }

//     final pattern = _parseJoystickData(data);

//     if (pattern.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('⚠️ Received data could not be parsed.')),
//       );
//       return;
//     }

//     setState(() {
//       _samplePattern = pattern;
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('📶 BLE sample captured')),
//     );
//   }

//   /// Parse incoming ESP32 joystick string into JSON format
//   /// Expected format: "X1:512,Y1:300,X2:700,Y2:520,X3:400"
//   Map<String, dynamic> _parseJoystickData(String data) {
//     final parts = data.split(',');
//     final Map<String, dynamic> result = {};
//     for (final part in parts) {
//       final kv = part.split(':');
//       if (kv.length == 2) {
//         final key = kv[0].trim().toLowerCase();
//         final val = int.tryParse(kv[1].trim());
//         if (val != null) {
//           // normalize keys to a consistent naming (e.g. x1, y1)
//           result[key] = val;
//         }
//       }
//     }
//     return result;
//   }

//   /// Save gesture to Supabase
//   Future<void> _saveGesture() async {
//     final name = _nameCtl.text.trim();
//     final message = _messageCtl.text.trim();

//     if (name.isEmpty || _samplePattern.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('⚠️ Please enter name and capture pattern')),
//       );
//       return;
//     }

//     setState(() => _isSaving = true);
//     final svc = SupabaseService.instance;

//     try {
//       await svc.insertGesture({
//         'gesture_name': name,
//         'esp32_pattern': _samplePattern,
//         'message': message,
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('✅ Gesture saved successfully')),
//       );

//       _nameCtl.clear();
//       _messageCtl.clear();
//       setState(() {
//         _samplePattern = {};
//         _isSaving = false;
//       });
//     } on PostgrestException catch (e) {
//       setState(() => _isSaving = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('❌ Supabase error: ${e.message}')),
//       );
//     } catch (e) {
//       setState(() => _isSaving = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('❌ Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Note: Do NOT declare Provider.of<BluetoothService>(context) here if you won't use it.
//     // We only access BluetoothService inside _captureSampleFromBLE() to avoid unused variable warnings.

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Gesture Training'),
//         actions: [
//           Switch(
//             value: _useSimulatedData,
//             onChanged: (v) {
//               setState(() => _useSimulatedData = v);
//             },
//           ),
//           const Padding(
//             padding: EdgeInsets.only(right: 12),
//             child: Center(child: Text('Simulate')),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: _nameCtl,
//                 decoration: const InputDecoration(
//                   labelText: 'Gesture Name',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: _messageCtl,
//                 decoration: const InputDecoration(
//                   labelText: 'Message (Text/Speech)',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // Capture + Live Preview
// if (!_useSimulatedData)
//   StreamBuilder<Map<String, dynamic>>(
//     stream: Provider.of<BluetoothService>(context).joystickStream,
//     builder: (context, snapshot) {
//       final data = snapshot.data ?? {};
//       return Column(
//         children: [
//           Text(
//             data.isEmpty
//                 ? 'Waiting for ESP32 data...'
//                 : 'Live Joystick: ${jsonEncode(data)}',
//             style: const TextStyle(fontSize: 13, color: Colors.indigo),
//           ),
//           const SizedBox(height: 8),
//           ElevatedButton.icon(
//             onPressed: () {
//               if (data.isEmpty) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('⚠️ No data received yet')),
//                 );
//               } else {
//                 setState(() {
//                   _samplePattern = data;
//                 });
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('📡 Captured current live data')),
//                 );
//               }
//             },
//             icon: const Icon(Icons.touch_app),
//             label: const Text('Capture Live Gesture'),
//           ),
//         ],
//       );
//     },
//   )
// else
//   ElevatedButton.icon(
//     onPressed: _captureSampleSimulated,
//     icon: const Icon(Icons.sensors),
//     label: const Text('Capture Simulated'),
//   ),


//               const SizedBox(height: 20),

//               if (_samplePattern.isNotEmpty)
//                 Card(
//                   color: Colors.indigo.shade50,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Captured Pattern:\n${const JsonEncoder.withIndent("  ").convert(_samplePattern)}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ),

//               const SizedBox(height: 16),
//               const Divider(),
//               const Text(
//                 '💡 Tip: When using a real ESP32 glove, ensure it sends joystick values '
//                 'like "X1:512,Y1:300,X2:700,Y2:520,X3:400" over Bluetooth. The app will '
//                 'auto-parse and match it with stored gestures.',
//                 style: TextStyle(fontSize: 13),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'dart:convert';
// import 'package:flutter/material.dart';
// // import 'package:postgrest/postgrest.dart'; // for Supabase exception handling
// import 'package:provider/provider.dart';
// import '../services/supabase_service.dart';
// import '../services/bluetooth_service.dart';

// class GestureTrainingScreen extends StatefulWidget {
//   const GestureTrainingScreen({super.key});

//   @override
//   State<GestureTrainingScreen> createState() => _GestureTrainingScreenState();
// }

// class _GestureTrainingScreenState extends State<GestureTrainingScreen> {
//   final _nameCtl = TextEditingController();
//   final _messageCtl = TextEditingController();
//   Map<String, dynamic> _samplePattern = {};
//   bool _useSimulatedData = true;

//   @override
//   void dispose() {
//     _nameCtl.dispose();
//     _messageCtl.dispose();
//     super.dispose();
//   }

//   /// Simulated ESP32 joystick data for offline testing
//   void _captureSampleSimulated() {
//     setState(() {
//       _samplePattern = {
//         'x1': 512,
//         'y1': 300,
//         'x2': 700,
//         'y2': 520,
//         'x3': 400,
//       };
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('🧪 Simulated gesture captured')),
//     );
//   }

//   /// Save gesture to Supabase
//   Future<void> _saveGestureToSupabase() async {
//     final name = _nameCtl.text.trim();
//     final message = _messageCtl.text.trim();

//     if (name.isEmpty || _samplePattern.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('⚠️ Please enter a name and capture a gesture first')),
//       );
//       return;
//     }

//     final svc = SupabaseService.instance;

//     try {
//       await svc.insertGesture({
//         'gesture_name': name,
//         'esp32_pattern': _samplePattern,
//         'message': message,
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('✅ Gesture saved successfully')),
//       );

//       _nameCtl.clear();
//       _messageCtl.clear();
//       setState(() {
//         _samplePattern = {};
//       });
//     } on PostgrestException catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('❌ Supabase error: ${e.message}')),
//       );
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('❌ Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bt = Provider.of<BluetoothService>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Gesture Training'),
//         actions: [
//           Switch(
//             value: _useSimulatedData,
//             onChanged: (v) => setState(() => _useSimulatedData = v),
//           ),
//           const Padding(
//             padding: EdgeInsets.only(right: 12),
//             child: Center(child: Text('Simulate')),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextField(
//                 controller: _nameCtl,
//                 decoration: const InputDecoration(
//                   labelText: 'Gesture Name',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               TextField(
//                 controller: _messageCtl,
//                 decoration: const InputDecoration(
//                   labelText: 'Message (Text/Speech)',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // ✅ Capture & Live Joystick Preview
//               !_useSimulatedData
//                   ? StreamBuilder<Map<String, dynamic>>(
//                       stream: bt.joystickStream,
//                       builder: (context, snapshot) {
//                         final data = snapshot.data ?? {};
//                         return Column(
//                           children: [
//                             Text(
//                               data.isEmpty
//                                   ? 'Waiting for ESP32 data...'
//                                   : 'Live Joystick: ${jsonEncode(data)}',
//                               style: const TextStyle(
//                                   fontSize: 13, color: Colors.indigo),
//                             ),
//                             const SizedBox(height: 8),
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 if (data.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                         content: Text('⚠️ No BLE data received yet')),
//                                   );
//                                 } else {
//                                   setState(() {
//                                     _samplePattern = data;
//                                   });
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                         content: Text('📡 Captured current live data')),
//                                   );
//                                 }
//                               },
//                               icon: const Icon(Icons.touch_app),
//                               label: const Text('Capture Live Gesture'),
//                             ),
//                           ],
//                         );
//                       },
//                     )
//                   : ElevatedButton.icon(
//                       onPressed: _captureSampleSimulated,
//                       icon: const Icon(Icons.sensors),
//                       label: const Text('Capture Simulated'),
//                     ),

//               const SizedBox(height: 20),

//               ElevatedButton.icon(
//                 onPressed: _saveGestureToSupabase,
//                 icon: const Icon(Icons.save),
//                 label: const Text('Save Gesture'),
//               ),

//               const SizedBox(height: 20),

//               if (_samplePattern.isNotEmpty)
//                 Card(
//                   color: Colors.indigo.shade50,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Captured Pattern:\n${const JsonEncoder.withIndent("  ").convert(_samplePattern)}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ),

//               const SizedBox(height: 16),
//               const Divider(),
//               const Text(
//                 '💡 Tip: Connect your ESP32 glove and ensure it sends joystick values '
//                 'like "X1:512,Y1:300,X2:700,Y2:520,X3:400" via Bluetooth. '
//                 'The app will automatically parse and let you capture live gestures.',
//                 style: TextStyle(fontSize: 13),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../services/supabase_service.dart';
// import '../services/bluetooth_service.dart';

// class GestureTrainingScreen extends StatefulWidget {
//   const GestureTrainingScreen({super.key});

//   @override
//   State<GestureTrainingScreen> createState() => _GestureTrainingScreenState();
// }

// class _GestureTrainingScreenState extends State<GestureTrainingScreen> {
//   final _nameCtl = TextEditingController();
//   final _messageCtl = TextEditingController();
//   Map<String, dynamic> _samplePattern = {};
//   bool _useSimulatedData = true;

//   @override
//   void dispose() {
//     _nameCtl.dispose();
//     _messageCtl.dispose();
//     super.dispose();
//   }

//   /// Simulated ESP32 joystick data for offline testing
//   void _captureSampleSimulated() {
//     setState(() {
//       _samplePattern = {
//         'x1': 512,
//         'y1': 300,
//         'x2': 700,
//         'y2': 520,
//         'x3': 400,
//       };
//     });

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('🧪 Simulated gesture captured')),
//     );
//   }

//   /// Save gesture to Supabase safely
//   Future<void> _saveGestureToSupabase() async {
//   final name = _nameCtl.text.trim();
//   final message = _messageCtl.text.trim();

//   if (name.isEmpty || _samplePattern.isEmpty) {
//     if (!mounted) return; // ✅ This guards this widget’s context
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('⚠️ Please enter a name and capture a gesture first')),
//     );
//     return;
//   }

//   final svc = SupabaseService.instance;

//   try {
//     await svc.insertGesture({
//       'gesture_name': name,
//       'esp32_pattern': _samplePattern,
//       'message': message,
//     });

//     if (!mounted) return; // ✅ Must be right before using context
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('✅ Gesture saved successfully')),
//     );

//     _nameCtl.clear();
//     _messageCtl.clear();
//     setState(() {
//       _samplePattern = {};
//     });
//   } catch (e) {
//     if (!mounted) return; // ✅ again before using context
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('❌ Error: $e')),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     final bt = Provider.of<BluetoothService>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Gesture Training'),
//         actions: [
//           Row(
//             children: [
//               const Text('Simulate', style: TextStyle(fontSize: 13)),
//               Switch(
//                 value: _useSimulatedData,
//                 onChanged: (v) => setState(() => _useSimulatedData = v),
//               ),
//               const SizedBox(width: 8),
//             ],
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Gesture name
//               TextField(
//                 controller: _nameCtl,
//                 decoration: const InputDecoration(
//                   labelText: 'Gesture Name',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // Message to speak/display
//               TextField(
//                 controller: _messageCtl,
//                 decoration: const InputDecoration(
//                   labelText: 'Message (Text/Speech)',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),

//               // ✅ Capture & Live Joystick Preview
//               !_useSimulatedData
//                   ? StreamBuilder<Map<String, dynamic>>(
//                       stream: bt.joystickStream,
//                       builder: (context, snapshot) {
//                         final data = snapshot.data ?? {};
//                         return Column(
//                           children: [
//                             Text(
//                               data.isEmpty
//                                   ? 'Waiting for ESP32 data...'
//                                   : 'Live Joystick: ${jsonEncode(data)}',
//                               style: const TextStyle(
//                                   fontSize: 13, color: Colors.indigo),
//                             ),
//                             const SizedBox(height: 8),
//                             ElevatedButton.icon(
//                               onPressed: () {
//                                 if (data.isEmpty) {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                         content: Text('⚠️ No BLE data received yet')),
//                                   );
//                                 } else {
//                                   setState(() {
//                                     _samplePattern = data;
//                                   });
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                         content: Text('📡 Captured current live data')),
//                                   );
//                                 }
//                               },
//                               icon: const Icon(Icons.touch_app),
//                               label: const Text('Capture Live Gesture'),
//                             ),
//                           ],
//                         );
//                       },
//                     )
//                   : ElevatedButton.icon(
//                       onPressed: _captureSampleSimulated,
//                       icon: const Icon(Icons.sensors),
//                       label: const Text('Capture Simulated'),
//                     ),

//               const SizedBox(height: 20),

//               // ✅ Save button
//               ElevatedButton.icon(
//                 onPressed: _saveGestureToSupabase,
//                 icon: const Icon(Icons.save),
//                 label: const Text('Save Gesture'),
//               ),

//               const SizedBox(height: 20),

//               // ✅ Show captured pattern
//               if (_samplePattern.isNotEmpty)
//                 Card(
//                   color: Colors.indigo.shade50,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       'Captured Pattern:\n${const JsonEncoder.withIndent("  ").convert(_samplePattern)}',
//                       style: const TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ),

//               const SizedBox(height: 16),
//               const Divider(),
//               const Text(
//                 '💡 Tip: Connect your ESP32 glove and ensure it sends joystick values '
//                 'like "X1:512,Y1:300,X2:700,Y2:520,X3:400" via Bluetooth. '
//                 'The app will automatically parse and let you capture live gestures.',
//                 style: TextStyle(fontSize: 13),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// lib/screens/gesture_training_screen.dart
// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:provider/provider.dart';

// import '../services/bluetooth_service.dart';
// import '../utils/gesture_map.dart'; // <-- the map file above

// class GestureTrainingScreen extends StatefulWidget {
//   const GestureTrainingScreen({super.key});

//   @override
//   State<GestureTrainingScreen> createState() => _GestureTrainingScreenState();
// }

// class _GestureTrainingScreenState extends State<GestureTrainingScreen> {
//   final FlutterTts _tts = FlutterTts();
//   late StreamSubscription<Map<String, dynamic>> _sub;
//   String _detected = 'Waiting for gesture...';
//   Map<String, dynamic> _latestRaw = {};

//   @override
//   void initState() {
//     super.initState();

//     // Subscribe to joystickStream from BluetoothService.
//     // Use listen: false because we only want the instance, not rebuild.
//     final bt = Provider.of<BluetoothService>(context, listen: false);

//     // Ensure joystickStream exists; if not, create a no-op stream
//     _sub = bt.joystickStream.listen((data) {
//       // data is Map<String, dynamic> coming from BluetoothService
//       _onJoystickData(data);
//     }, onError: (err) {
//       debugPrint('Joystick stream error: $err');
//     });
//   }

//   @override
//   void dispose() {
//     _sub.cancel();
//     _tts.stop();
//     super.dispose();
//   }

//   // safe convert helper
//   int _toInt(dynamic v) {
//     if (v == null) return 0;
//     if (v is int) return v;
//     if (v is double) return v.toInt();
//     final s = v.toString();
//     return int.tryParse(s) ?? 0;
//   }

//   void _onJoystickData(Map<String, dynamic> data) {
//     // Save raw data to show in UI
//     _latestRaw = Map<String, dynamic>.from(data);

//     // Example expecting keys like "f1", "f2" or "x1","y1" depending on your ESP32
//     // Adapt keys below to match what your glove sends.
//     final f1 = _toInt(data['f1'] ?? data['F1'] ?? data['x1'] ?? data['X1']);
//     final f2 = _toInt(data['f2'] ?? data['F2'] ?? data['y1'] ?? data['Y1']);
//     // Add more sensor reads if you need

//     // Build pattern
//     String pattern = '';
//     if (f1 > 800 && f2 < 400) {
//       pattern = 'F1_HIGH_F2_LOW';
//     } else if (f1 < 400 && f2 > 800) {
//       pattern = 'F1_LOW_F2_HIGH';
//     } else if (f1 < 300 && f2 < 300) {
//       pattern = 'ALL_LOW';
//     } else if (f1 > 900 && f2 > 900) {
//       pattern = 'ALL_HIGH';
//     } else {
//       pattern = ''; // no match
//     }

//     // Look up in gestureToWord map
//     final recognized = (pattern.isNotEmpty && gestureToWord.containsKey(pattern))
//         ? gestureToWord[pattern]
//         : null;

//     if (recognized != null && recognized != _detected) {
//       // Update UI and speak
//       if (mounted) {
//         setState(() => _detected = recognized);
//       }
//       _speak(recognized);
//     } else if (recognized == null && mounted) {
//       // Optionally clear label if no recognized pattern
//       setState(() => _detected = 'Waiting for gesture...');
//     }
//   }

//   Future<void> _speak(String text) async {
//     try {
//       await _tts.setLanguage('en-US');
//       await _tts.setSpeechRate(0.9);
//       await _tts.speak(text);
//     } catch (e) {
//       debugPrint('TTS error: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final rawPretty = _latestRaw.isEmpty ? '—' : _latestRaw.toString();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Gesture Training'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Card(
//               color: Colors.grey.shade900,
//               child: ListTile(
//                 leading: const Icon(Icons.sensors, color: Colors.amber),
//                 title: Text(
//                   _detected,
//                   style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Text('Live mapping result'),
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               'Raw sensor data:',
//               style: TextStyle(color: Colors.grey.shade400),
//             ),
//             const SizedBox(height: 8),
//             Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.black54,
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 rawPretty,
//                 style: const TextStyle(color: Colors.white70),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               icon: const Icon(Icons.save),
//               label: const Text('Save this mapping (manual flow)'),
//               onPressed: () {
//                 // Implement saving mapping to your Supabase or local DB if you want
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Saving mappings is not implemented here')),
//                 );
//               },
//             ),
//             const SizedBox(height: 12),
//             const Text(
//               'Tip: Move the glove to the gesture position you want to map. '
//               'Adjust thresholds in code or build a training flow to save patterns.',
//               style: TextStyle(color: Colors.white70),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../services/bluetooth_service.dart';
// import '../services/ai_commication_service.dart';

class GestureTrainingScreen extends StatefulWidget {
  const GestureTrainingScreen({super.key});

  @override
  
  State<GestureTrainingScreen> createState() => _GestureTrainingScreenState();
}

class _GestureTrainingScreenState extends State<GestureTrainingScreen> {
  String detectedGesture = "No gesture yet 🖐";

  @override
  Widget build(BuildContext context) {
    final ble = Provider.of<BluetoothService>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text(
          "Gesture Training",
          style: TextStyle(
            color: Color(0xFFFFD700),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFFFFD700)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🌌 Lottie animation
          Lottie.asset(
            'assets/ai_wave.json',
            height: 220,
            repeat: true,
          ),
          const SizedBox(height: 30),

          // 🖐 Live gesture display
          StreamBuilder<String>(
            stream: ble.gestureStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                detectedGesture = snapshot.data!;
              }

              return AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFD700),
                      Color(0xFFFFB700),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      spreadRadius: 1,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Text(
                  "🖐 $detectedGesture",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 50),

          // 🧠 Info Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Move your glove to train and verify each gesture.\n"
              "Recognized gestures will appear above in real time and be spoken aloud by the app.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 40),

          // Back Button
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
            label: const Text("Back to Home"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD700),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}