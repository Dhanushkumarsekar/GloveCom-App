// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'screens/ble_connection_screen.dart';
// import 'screens/gesture_training_screen.dart';
// import 'screens/voice_assistant_screen.dart';
// import 'screens/speech_history_screen.dart';
// import 'services/bluetooth_service.dart';
// import 'services/supabase_service.dart';
// import 'services/tts_service.dart';
// import 'utils/constants.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");
//   await SupabaseService.init();
//   runApp(const GloveComApp());
// }

// class GloveComApp extends StatelessWidget {
//   const GloveComApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BluetoothService()),
//         Provider(create: (_) => TTSService()),
//         Provider(create: (_) => SupabaseService.instance),
//       ],
//       child: MaterialApp(
//         title: 'GloveCom',
//         theme: ThemeData(
//           primarySwatch: Colors.indigo,
//         ),
//         home: const HomeScreen(),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selected = 0;
//   final _screens = const [
//     BLEConnectionScreen(),
//     VoiceAssistantScreen(),
//     GestureTrainingScreen(),
//     SpeechHistoryScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _screens[_selected],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selected,
//         onTap: (i) => setState(() => _selected = i),
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.bluetooth), label: 'BLE'),
//           BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Voice'),
//           BottomNavigationBarItem(icon: Icon(Icons.edit), label: 'Train'),
//           BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
//         ],
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'services/bluetooth_service.dart';
// import 'services/supabase_service.dart';
// import 'constants.dart';
// import 'screens/gesture_training_screen.dart'; // your existing screen

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");
//   await SupabaseService.init();

//   runApp(const GloveComApp());
// }

// class GloveComApp extends StatelessWidget {
//   const GloveComApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BluetoothService()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: APP_TITLE,
//         theme: ThemeData(
//           primarySwatch: Colors.indigo,
//           useMaterial3: true,
//         ),
//         home: const GestureTrainingScreen(),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:provider/provider.dart';
// import 'package:lottie/lottie.dart'; // add lottie in pubspec.yaml
// import 'services/bluetooth_service.dart';
// import 'services/supabase_service.dart';
// import 'screens/gesture_training_screen.dart';
// import 'screens/speech_history_screen.dart';
// import 'constants.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");
//   await SupabaseService.init();
//   runApp(const GloveComApp());
// }

// /// Root App Widget
// class GloveComApp extends StatelessWidget {
//   const GloveComApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BluetoothService()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: APP_TITLE,
//         theme: ThemeData(
//           colorSchemeSeed: Colors.indigo,
//           useMaterial3: true,
//           fontFamily: 'Poppins',
//         ),
//         home: const SplashScreen(),
//       ),
//     );
//   }
// }

// /// ---------------------------
// /// 🌟 SPLASH SCREEN
// /// ---------------------------
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const HomeScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.indigo.shade50,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Lottie.asset('assets/glovecom.json', width: 180, height: 180,
//                 repeat: true, fit: BoxFit.contain),
//             const SizedBox(height: 24),
//             Text(APP_TITLE,
//                 style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.indigo.shade700)),
//             const SizedBox(height: 10),
//             const Text(
//               "Gesture to Speech Translator",
//               style: TextStyle(fontSize: 14, color: Colors.black54),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// ---------------------------
// /// 🏠 HOME SCREEN (Navigation)
// /// ---------------------------
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bt = Provider.of<BluetoothService>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(APP_TITLE),
//         centerTitle: true,
//         backgroundColor: Colors.indigo.shade600,
//         foregroundColor: Colors.white,
//       ),
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.indigo.shade100, Colors.white],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.handshake, size: 100, color: Colors.indigo.shade400),
//               const SizedBox(height: 20),
//               Text(
//                 bt.isConnected
//                     ? "🟢 Connected to GloveCom-ESP32"
//                     : "🔴 Not Connected",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: bt.isConnected ? Colors.green : Colors.red,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               _HomeButton(
//                 icon: Icons.gesture,
//                 label: "Gesture Training",
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const GestureTrainingScreen(),
//                   ),
//                 ),
//               ),
//               _HomeButton(
//                 icon: Icons.history,
//                 label: "Speech History",
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const SpeechHistoryScreen(),
//                   ),
//                 ),
//               ),
//               _HomeButton(
//                 icon: Icons.bluetooth_connected,
//                 label: bt.isConnected ? "Disconnect Device" : "Scan & Connect",
//                 onTap: () async {
//                   if (bt.isConnected) {
//                     await bt.disconnect();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('🔌 Disconnected')),
//                     );
//                   } else {
//                     await bt.startScan();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content:
//                             Text('🔍 Scanning for GloveCom-ESP32...'),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Reusable Card Button
// class _HomeButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;

//   const _HomeButton({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: Ink(
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.9),
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.indigo.shade100,
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Icon(icon, color: Colors.indigo, size: 28),
//                 const SizedBox(width: 20),
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:provider/provider.dart';
// import 'package:lottie/lottie.dart';
// import 'services/bluetooth_service.dart';
// import 'services/supabase_service.dart';
// import 'screens/gesture_training_screen.dart';
// import 'screens/speech_history_screen.dart';
// import 'constants.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");
//   await SupabaseService.init();
//   runApp(const GloveComApp());
// }

// /// 🌟 Root App Widget
// class GloveComApp extends StatelessWidget {
//   const GloveComApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BluetoothService()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: APP_TITLE,
//         theme: ThemeData(
//           colorSchemeSeed: Colors.indigo,
//           useMaterial3: true,
//           fontFamily: 'Poppins',
//         ),
//         home: const SplashScreen(),
//       ),
//     );
//   }
// }

// /// ---------------------------
// /// 🌟 SPLASH SCREEN
// /// ---------------------------
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//  @override
// void initState() {
//   super.initState();
//   Future.delayed(const Duration(seconds: 3), () async {
//     // Some async work
//     await Future.delayed(const Duration(seconds: 2));

//     // ✅ Always check if the widget is still mounted before using context
//     if (!mounted) return;

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (_) => const HomeScreen()),
//     );
//   });
// }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.indigo.shade50,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Lottie.asset(
//               'assets/glovecom.json',
//               width: 180,
//               height: 180,
//               repeat: true,
//               fit: BoxFit.contain,
//             ),
//             const SizedBox(height: 24),
//             Text(
//               APP_TITLE,
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.indigo.shade700,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Gesture to Speech Translator",
//               style: TextStyle(fontSize: 14, color: Colors.black54),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// ---------------------------
// /// 🏠 HOME SCREEN (Main Menu)
// /// ---------------------------
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bt = Provider.of<BluetoothService>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(APP_TITLE),
//         centerTitle: true,
//         backgroundColor: Colors.indigo.shade600,
//         foregroundColor: Colors.white,
//       ),
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.indigo.shade100, Colors.white],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.handshake, size: 100, color: Colors.indigo.shade400),
//               const SizedBox(height: 20),
//               Text(
//                 bt.isConnected
//                     ? "🟢 Connected to GloveCom-ESP32"
//                     : "🔴 Not Connected",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: bt.isConnected ? Colors.green : Colors.red,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               _HomeButton(
//                 icon: Icons.gesture,
//                 label: "Gesture Training",
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const GestureTrainingScreen(),
//                   ),
//                 ),
//               ),
//               _HomeButton(
//                 icon: Icons.history,
//                 label: "Speech History",
//                 onTap: () => Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const SpeechHistoryScreen(),
//                   ),
//                 ),
//               ),
//               _HomeButton(
//                 icon: Icons.bluetooth_connected,
//                 label: bt.isConnected
//                     ? "Disconnect Device"
//                     : "Scan & Connect",
//                 onTap: () async {
//                   if (bt.isConnected) {
//                     await bt.disconnect();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('🔌 Disconnected')),
//                     );
//                   } else {
//                     await bt.startScan();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('🔍 Scanning for GloveCom-ESP32...'),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Reusable Card Button Widget
// class _HomeButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;

//   const _HomeButton({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: Ink(
//           decoration: BoxDecoration(
//             color: Colors.white.withValues(alpha: 0.9), // ✅ fixed
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.indigo.shade100,
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Icon(icon, color: Colors.indigo, size: 28),
//                 const SizedBox(width: 20),
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:provider/provider.dart';
// import 'package:lottie/lottie.dart';
// import 'services/bluetooth_service.dart';
// import 'services/supabase_service.dart';
// import 'screens/gesture_training_screen.dart';
// import 'screens/speech_history_screen.dart';
// import 'constants.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await dotenv.load(fileName: ".env");
//   await SupabaseService.init();
//   runApp(const GloveComApp());
// }

// /// 🌟 Root App Widget
// class GloveComApp extends StatelessWidget {
//   const GloveComApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BluetoothService()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: APP_TITLE,
//         theme: ThemeData(
//           colorSchemeSeed: Colors.indigo,
//           useMaterial3: true,
//           fontFamily: 'Poppins',
//         ),
//         home: const SplashScreen(),
//       ),
//     );
//   }
// }

// /// ---------------------------
// /// 🌟 SPLASH SCREEN
// /// ---------------------------
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 3), () async {
//       await Future.delayed(const Duration(seconds: 2));
//       if (!mounted) return; // ✅ Safe context usage
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (_) => const HomeScreen()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.indigo.shade50,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Lottie.asset(
//               'assets/glovecom.json',
//               width: 180,
//               height: 180,
//               repeat: true,
//               fit: BoxFit.contain,
//             ),
//             const SizedBox(height: 24),
//             Text(
//               APP_TITLE,
//               style: TextStyle(
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.indigo.shade700,
//               ),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Gesture to Speech Translator",
//               style: TextStyle(fontSize: 14, color: Colors.black54),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /// ---------------------------
// /// 🏠 HOME SCREEN (Main Menu)
// /// ---------------------------
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bt = Provider.of<BluetoothService>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(APP_TITLE),
//         centerTitle: true,
//         backgroundColor: Colors.indigo.shade600,
//         foregroundColor: Colors.white,
//       ),
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Colors.indigo.shade100, Colors.white],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(18.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(Icons.handshake, size: 100, color: Colors.indigo.shade400),
//               const SizedBox(height: 20),
//               Text(
//                 bt.isConnected
//                     ? "🟢 Connected to GloveCom-ESP32"
//                     : "🔴 Not Connected",
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: bt.isConnected ? Colors.green : Colors.red,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               const SizedBox(height: 40),
//               _HomeButton(
//                 icon: Icons.gesture,
//                 label: "Gesture Training",
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const GestureTrainingScreen(),
//                     ),
//                   );
//                 },
//               ),
//               _HomeButton(
//                 icon: Icons.history,
//                 label: "Speech History",
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const SpeechHistoryScreen(),
//                     ),
//                   );
//                 },
//               ),
//               _HomeButton(
//                 icon: Icons.bluetooth_connected,
//                 label:
//                     bt.isConnected ? "Disconnect Device" : "Scan & Connect",
//                 onTap: () async {
//                   if (bt.isConnected) {
//                     await bt.disconnect();
//                     if (!context.mounted) return; // ✅ Safe context usage
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('🔌 Disconnected')),
//                     );
//                   } else {
//                     await bt.startScan();
//                     if (!context.mounted) return; // ✅ Safe context usage
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text('🔍 Scanning for GloveCom-ESP32...'),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// ---------------------------
// /// 🔘 REUSABLE BUTTON WIDGET
// /// ---------------------------
// class _HomeButton extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;

//   const _HomeButton({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(20),
//         child: Ink(
//           decoration: BoxDecoration(
//             color: Colors.white.withValues(alpha: 0.9), // ✅ Compatible fix
//             borderRadius: BorderRadius.circular(20),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.indigo.shade100,
//                 blurRadius: 8,
//                 offset: const Offset(0, 4),
//               ),
//             ],
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(18.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Icon(icon, color: Colors.indigo, size: 28),
//                 const SizedBox(width: 20),
//                 Text(
//                   label,
//                   style: const TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'services/bluetooth_service.dart';
// import 'screens/home_screen.dart'; // your first screen

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BluetoothService()),
//       ],
//       child: const GloveComApp(),
//     ),
//   );
// }

// class GloveComApp extends StatelessWidget {
//   const GloveComApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'GloveCom',
//       theme: ThemeData.light(), // or .light() if you prefer
//       debugShowCheckedModeBanner: false,
//       home: const HomeScreen(),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import '../services/bluetooth_service.dart';
// import 'gesture_training_screen.dart';
// import 'voice_assistant_screen.dart';
// import 'speech_history_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bt = Provider.of<BluetoothService>(context);
//     final Color gold = const Color(0xFFFFD700); // Gold
//     final Color darkBg = const Color(0xFF0D0D0D); // Dark background

//     return Scaffold(
//       backgroundColor: darkBg,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "GloveCom",
//           style: TextStyle(
//             color: gold,
//             fontSize: 26,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.2,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.settings, color: Colors.white70),
//             onPressed: () {},
//           ),
//         ],
//       ),

//       // BODY
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Lottie Animation or Glove Image
//               Center(
//                 child: Lottie.asset(
//                   'assets/lottie/glove_animation.json',
//                   height: 220,
//                   repeat: true,
//                 ),
//               ),
//               const SizedBox(height: 15),

//               // Bluetooth Status
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: gold, width: 1.5),
//                   boxShadow: [
//                     BoxShadow(
//                       color: gold.withValues(alpha: 0.25),
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                     )
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       bt.isConnected
//                           ? Icons.bluetooth_connected
//                           : Icons.bluetooth_disabled,
//                       color: bt.isConnected ? gold : Colors.redAccent,
//                       size: 30,
//                     ),
//                     const SizedBox(width: 10),
//                     Text(
//                       bt.isConnected ? "Connected" : "Disconnected",
//                       style: TextStyle(
//                         color: bt.isConnected ? gold : Colors.redAccent,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Buttons Section
//               GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 15,
//                 mainAxisSpacing: 15,
//                 children: [
//                   _featureCard(
//                     context,
//                     title: "Gesture\nTraining",
//                     icon: Icons.touch_app,
//                     gold: gold,
//                     screen: const GestureTrainingScreen(),
//                   ),
//                   _featureCard(
//                     context,
//                     title: "Voice\nAssistant",
//                     icon: Icons.mic,
//                     gold: gold,
//                     screen: const VoiceAssistantScreen(),
//                   ),
//                   _featureCard(
//                     context,
//                     title: "Speech\nHistory",
//                     icon: Icons.history,
//                     gold: gold,
//                     screen: const SpeechHistoryScreen(),
//                   ),
//                   _featureCard(
//                     context,
//                     title: bt.isConnected ? "Disconnect" : "Scan & Connect",
//                     icon: bt.isConnected
//                         ? Icons.bluetooth_disabled
//                         : Icons.bluetooth_searching,
//                     gold: gold,
//                     onTap: () async {
//                       if (bt.isConnected) {
//                         await bt.disconnect();
//                         if (!context.mounted) return; // ✅ Safe context usage
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("🔌 Disconnected")),
//                         );
//                       } else {
//                         await bt.startScan();
//                         if (!context.mounted) return; // ✅ Safe context usage
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text("🔍 Scanning for devices...")),
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 30),

//               // Footer Text
//               Text(
//                 "Empowering Communication with GloveCom 🤖",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: gold.withValues(alpha: 0.8),
//                   fontSize: 14,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // 🔸 Reusable Feature Card Widget
//   Widget _featureCard(
//     BuildContext context, {
//     required String title,
//     required IconData icon,
//     required Color gold,
//     Widget? screen,
//     Future<void> Function()? onTap,
//   }) {
//     return InkWell(
//       onTap: screen != null
//           ? () => Navigator.push(
//               context, MaterialPageRoute(builder: (_) => screen))
//           : onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xFF121212),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: gold.withValues(alpha: 0.7), width: 1.5),
//           boxShadow: [
//             BoxShadow(
//               color: gold.withValues(alpha: 0.15),
//               blurRadius: 8,
//               spreadRadius: 1,
//               offset: const Offset(0, 3),
//             )
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: gold, size: 38),
//             const SizedBox(height: 10),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: gold,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import '../services/bluetooth_service.dart';


// // import 'package:flutter/material.dart';
// // import 'package:flutter_dotenv/flutter_dotenv.dart';
// // import 'package:provider/provider.dart';
// // import 'package:lottie/lottie.dart';
// // import 'services/bluetooth_service.dart';
// // import 'services/supabase_service.dart';
// // import 'screens/gesture_training_screen.dart';
// // import 'screens/speech_history_screen.dart';
// // import 'constants.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bt = Provider.of<BluetoothService>(context);
//     final Color gold = const Color(0xFFFFD700);
//     final Color darkBg = const Color(0xFF0D0D0D);

//     return Scaffold(
//       backgroundColor: darkBg,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 0,
//         centerTitle: true,
//         title: Text(
//           "GloveCom",
//           style: TextStyle(
//             color: gold,
//             fontSize: 26,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 1.2,
//           ),
//         ),
//       ),

//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               // Animation
//               Center(
//                 child: Lottie.asset(
//                   'assets/lottie/glove_animation.json',
//                   height: 220,
//                   repeat: true,
//                 ),
//               ),
//               const SizedBox(height: 15),

//               // Bluetooth Status
//               Container(
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: gold, width: 1.5),
//                   boxShadow: [
//                     BoxShadow(
//                       color: gold.withValues(alpha: 0.25),
//                       blurRadius: 10,
//                       spreadRadius: 2,
//                     )
//                   ],
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       bt.isConnected
//                           ? Icons.bluetooth_connected
//                           : Icons.bluetooth_disabled,
//                       color: bt.isConnected ? gold : Colors.redAccent,
//                       size: 30,
//                     ),
//                     const SizedBox(width: 10),
//                     Text(
//                       bt.isConnected ? "Connected" : "Disconnected",
//                       style: TextStyle(
//                         color: bt.isConnected ? gold : Colors.redAccent,
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Buttons
//               GridView.count(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 15,
//                 mainAxisSpacing: 15,
//                 children: [
//                   _featureCard(
//                     context,
//                     title: "Gesture\nTraining",
//                     icon: Icons.touch_app,
//                     gold: gold,
//                     screen: const GestureTrainingScreen(),
//                   ),
//                   _featureCard(
//                     context,
//                     title: "Voice\nAssistant",
//                     icon: Icons.mic,
//                     gold: gold,
//                     screen: const VoiceAssistantScreen(),
//                   ),
//                   _featureCard(
//                     context,
//                     title: "Speech\nHistory",
//                     icon: Icons.history,
//                     gold: gold,
//                     screen: const SpeechHistoryScreen(),
//                   ),
//                   _featureCard(
//                     context,
//                     title: bt.isConnected ? "Disconnect" : "Scan & Connect",
//                     icon: bt.isConnected
//                         ? Icons.bluetooth_disabled
//                         : Icons.bluetooth_searching,
//                     gold: gold,
//                     onTap: () async {
//                       if (bt.isConnected) {
//                         await bt.disconnect();
//                         if (!context.mounted) return;
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("🔌 Disconnected")),
//                         );
//                       } else {
//                         await bt.startScan();
//                         if (!context.mounted) return;
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(
//                               content: Text("🔍 Scanning for devices...")),
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 30),
//               Text(
//                 "Empowering Communication with GloveCom 🤖",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: gold.withValues(alpha: 0.8),
//                   fontSize: 14,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _featureCard(
//     BuildContext context, {
//     required String title,
//     required IconData icon,
//     required Color gold,
//     Widget? screen,
//     Future<void> Function()? onTap,
//   }) {
//     return InkWell(
//       onTap: screen != null
//           ? () => Navigator.push(
//               context, MaterialPageRoute(builder: (_) => screen))
//           : onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         decoration: BoxDecoration(
//           color: const Color(0xFF121212),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: gold.withValues(alpha: 0.7), width: 1.5),
//           boxShadow: [
//             BoxShadow(
//               color: gold.withValues(alpha: 0.15),
//               blurRadius: 8,
//               spreadRadius: 1,
//               offset: const Offset(0, 3),
//             )
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: gold, size: 38),
//             const SizedBox(height: 10),
//             Text(
//               title,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 color: gold,
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ----------------------------------------------------------------------
// // ✅ Inline Placeholder Screens (no missing imports)
// // ----------------------------------------------------------------------

// class GestureTrainingScreen extends StatelessWidget {
//   const GestureTrainingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           "Gesture Training Screen (Coming Soon)",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }

// class VoiceAssistantScreen extends StatelessWidget {
//   const VoiceAssistantScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           "Voice Assistant Screen (Coming Soon)",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }

// class SpeechHistoryScreen extends StatelessWidget {
//   const SpeechHistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Text(
//           "Speech History Screen (Coming Soon)",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'screens/home_screen.dart';
// import 'services/bluetooth_service.dart';

// void main() {
//   runApp(const GloveComApp());
// }

// class GloveComApp extends StatelessWidget {
//   const GloveComApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BluetoothService()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'GloveCom',
//         theme: ThemeData.dark().copyWith(
//           scaffoldBackgroundColor: const Color(0xFF0A0A0A),
//           colorScheme: ColorScheme.fromSeed(
//             seedColor: const Color(0xFFD4AF37), // Dark gold theme
//             brightness: Brightness.dark,
//           ),
//           appBarTheme: const AppBarTheme(
//             backgroundColor: Colors.black,
//             titleTextStyle: TextStyle(
//               color: Color(0xFFD4AF37),
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//             ),
//             iconTheme: IconThemeData(color: Color(0xFFD4AF37)),
//           ),
//         ),
//         home: const HomeScreen(),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'services/bluetooth_service.dart';
// import 'screens/home_screen.dart';
// import 'screens/gesture_training_screen.dart';
// import 'screens/voice_assistant_screen.dart';
// import 'screens/speech_history_screen.dart';
// import 'screens/ble_connection_screen.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const GloveComApp());
// }

// class GloveComApp extends StatelessWidget {
//   const GloveComApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BluetoothService()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'GloveCom',
//         theme: ThemeData.dark().copyWith(
//           scaffoldBackgroundColor: const Color(0xFF0A0A0A),
//           colorScheme: ColorScheme.fromSeed(
//             seedColor: const Color(0xFFD4AF37), // gold theme
//             brightness: Brightness.dark,
//           ),
//           appBarTheme: const AppBarTheme(
//             backgroundColor: Colors.black,
//             centerTitle: true,
//             titleTextStyle: TextStyle(
//               color: Color(0xFFD4AF37),
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//             ),
//             iconTheme: IconThemeData(color: Color(0xFFD4AF37)),
//           ),
//           elevatedButtonTheme: ElevatedButtonThemeData(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFD4AF37),
//               foregroundColor: Colors.black,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ),
//         initialRoute: '/',
//         routes: {
//           '/': (context) => const HomeScreen(),
//           '/gesture-training': (context) => const GestureTrainingScreen(),
//           '/voice-assistant': (context) => const VoiceAssistantScreen(),
//           '/speech-history': (context) => const SpeechHistoryScreen(),
//           '/ble-connection': (context) => const BLEConnectionScreen(),
//         },
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'services/bluetooth_service.dart';
// import 'screens/home_screen.dart';
// import 'screens/gesture_training_screen.dart';
// import 'screens/voice_assistant_screen.dart';
// import 'screens/speech_history_screen.dart';
// import 'screens/ble_connection_screen.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   runApp(const GloveComApp());
// }

// class GloveComApp extends StatelessWidget {
//   const GloveComApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => BluetoothService()),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'GloveCom',
//         theme: ThemeData.dark().copyWith(
//           scaffoldBackgroundColor: const Color(0xFF0A0A0A),
//           colorScheme: ColorScheme.fromSeed(
//             seedColor: const Color(0xFFD4AF37), // Gold accent theme
//             brightness: Brightness.dark,
//           ),
//           appBarTheme: const AppBarTheme(
//             backgroundColor: Colors.black,
//             centerTitle: true,
//             titleTextStyle: TextStyle(
//               color: Color(0xFFD4AF37),
//               fontWeight: FontWeight.bold,
//               fontSize: 22,
//             ),
//             iconTheme: IconThemeData(color: Color(0xFFD4AF37)),
//           ),
//           elevatedButtonTheme: ElevatedButtonThemeData(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFFD4AF37),
//               foregroundColor: Colors.black,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//           ),
//         ),
//         initialRoute: '/',
//         routes: {
//           '/': (context) => const HomeScreen(),
//           '/gesture-training': (context) => const GestureTrainingScreen(),
//           '/voice-assistant': (context) => const VoiceAssistantScreen(),
//           '/speech-history': (context) => const SpeechHistoryScreen(),
//           '/ble-connection': (context) => const BLEConnectionScreen(),
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/bluetooth_service.dart';
import 'services/ai_commication_service.dart';
import 'screens/home_screen.dart';
import 'screens/gesture_training_screen.dart';
import 'screens/voice_assistant_screen.dart';
import 'screens/speech_sentence_screen.dart';
import 'screens/speech_history_screen.dart';
import 'screens/ble_connection_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GloveComApp());
}

class GloveComApp extends StatelessWidget {
  const GloveComApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BluetoothService()),
        ChangeNotifierProvider(create: (_) => AICommunicationService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'GloveCom',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF0A0A0A),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFFD700),
            brightness: Brightness.dark,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Color(0xFFFFD700),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
            iconTheme: IconThemeData(color: Color(0xFFFFD700)),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          '/gesture-training': (context) => const GestureTrainingScreen(),
          '/voice-assistant': (context) => const VoiceAssistantScreen(),
          '/speech-sentence': (context) => const SpeechSentenceScreen(),
          '/speech-history': (context) => const SpeechHistoryScreen(),
          '/ble-connection': (context) => const BLEConnectionScreen(),
        },
      ),
    );
  }
}
