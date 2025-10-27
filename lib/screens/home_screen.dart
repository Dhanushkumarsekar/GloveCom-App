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
//   if (bt.isConnected) {
//     await bt.disconnect();
//     if (!context.mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("🔌 Disconnected")),
//     );
//   } else {
//     await bt.startScan();
//     if (!context.mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text("🔍 Scanning for devices...")),
//     );
//   }
// },


//               const SizedBox(height: 30),

//               // Footer Text
//               Text(
//                 "Empowering Communication with GloveCom 🤖",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: gold.withOpacity(0.8),
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
//           border: Border.all(color: gold.withOpacity(0.7), width: 1.5),
//           boxShadow: [
//             BoxShadow(
//               color: gold.withOpacity(0.15),
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
// import 'gesture_training_screen.dart';
// import 'voice_assistant_screen.dart';
// import 'speech_history_screen.dart';
// import 'ble_connection_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0A0A0A),
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         elevation: 10,
//         shadowColor: const Color(0xFFD4AF37).withValues(alpha: 0.5),
//         title: const Text(
//           "GloveCom AI",
//           style: TextStyle(
//             color: Color(0xFFD4AF37),
//             fontWeight: FontWeight.bold,
//             fontSize: 26,
//             letterSpacing: 1.2,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Stack(
//         children: [
//           // ⚡ Futuristic glowing background
//           Container(
//             decoration: BoxDecoration(
//               gradient: RadialGradient(
//                 colors: [
//                   const Color(0xFF1A1A1A),
//                   Colors.black,
//                 ],
//                 radius: 1.0,
//               ),
//             ),
//           ),

//           // ✨ Floating particle animation (using Lottie)
//           Align(
//             alignment: Alignment.topCenter,
//             child: Opacity(
//               opacity: 0.3,
//               child: Lottie.asset(
//                 'assets/animations/ai_particles.json',
//                 height: 250,
//                 repeat: true,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           // 🌟 Main content
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // 🧠 GloveCom AI Title
//                 Column(
//                   children: const [
//                     Text(
//                       "GloveCom ",
//                       style: TextStyle(
//                         fontSize: 32,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFFD4AF37),
//                         letterSpacing: 1.5,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "Sign • Speak • Connect",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white70,
//                         letterSpacing: 1.2,
//                       ),
//                     ),
//                   ],
//                 ),

//                 // 🖐 Animated Hand or Glove Lottie
//                 Lottie.asset(
//                   'assets/animations/hand_motion.json',
//                   height: 220,
//                   repeat: true,
//                 ),

//                 // ⚙ AI Mode Buttons Grid
//                 GridView.count(
//                   crossAxisCount: 2,
//                   shrinkWrap: true,
//                   crossAxisSpacing: 16,
//                   mainAxisSpacing: 16,
//                   children: [
//                     _buildAIModeButton(
//                       context,
//                       icon: Icons.front_hand,
//                       title: "Gesture Trainer",
//                       nextScreen: const GestureTrainingScreen(),
//                     ),
//                     _buildAIModeButton(
//                       context,
//                       icon: Icons.mic,
//                       title: "Voice Assistant",
//                       nextScreen: const VoiceAssistantScreen(),
//                     ),
//                     _buildAIModeButton(
//                       context,
//                       icon: Icons.bluetooth,
//                       title: "BLE Connection",
//                       nextScreen: const BLEConnectionScreen(),
//                     ),
//                     _buildAIModeButton(
//                       context,
//                       icon: Icons.history,
//                       title: "Speech History",
//                       nextScreen: const SpeechHistoryScreen(),
//                     ),
//                   ],
//                 ),

//                 // 💡 AI Footer
//                 const Text(
//                   "AI Powered | GloveCom 2025",
//                   style: TextStyle(
//                     fontSize: 13,
//                     color: Color(0xFFD4AF37),
//                     letterSpacing: 1.2,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🌟 Futuristic Gold Buttons with Glow Effect
//   Widget _buildAIModeButton(
//       BuildContext context, {
//         required IconData icon,
//         required String title,
//         required Widget nextScreen,
//       }) {
//     return GestureDetector(
//       onTap: () {
//         if (context.mounted) {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => nextScreen),
//           );
//         }
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           gradient: const LinearGradient(
//             colors: [Color(0xFFD4AF37), Color(0xFFB8860B)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xFFD4AF37).withValues(alpha: 0.4),
//               blurRadius: 10,
//               spreadRadius: 2,
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: Colors.black, size: 40),
//             const SizedBox(height: 10),
//             Text(
//               title,
//               style: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 15,
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
// import 'package:google_fonts/google_fonts.dart';
// import 'ble_connection_screen.dart';
// import 'gesture_training_screen.dart';
// import 'voice_assistant_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: const Color(0xFF0D0D0D),
//       body: Stack(
//         children: [
//           // Background gradient glow
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFF0D0D0D),
//                   Color(0xFF1C1C1C),
//                   Color(0xFF0A0A0A),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),

//           // Animated overlay glow
//           Positioned.fill(
//             child: Align(
//               alignment: Alignment.topCenter,
//               child: Opacity(
//                 opacity: 0.5,
//                 child: Lottie.asset(
//                   'assets/glovecom_ai.json',
//                   width: screenWidth * 0.9,
//                   repeat: true,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),

//           // Main content
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Logo or Lottie intro
//                   Lottie.asset(
//                     'assets/ai_wave.json',
//                     width: 200,
//                     height: 200,
//                     repeat: true,
//                   ),
//                   const SizedBox(height: 20),

//                   // Title
//                   Text(
//                     "GloveCom",
//                     style: GoogleFonts.orbitron(
//                       fontSize: 42,
//                       fontWeight: FontWeight.bold,
//                       color: const Color(0xFFFFD700),
//                       letterSpacing: 2,
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   Text(
//                     "Sign Language → Speech & Text",
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.poppins(
//                       color: Colors.white.withValues(alpha: 0.8),

//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 60),

//                   // Buttons
//                   _buildNavButton(
//                     context,
//                     title: "🔗 Connect Glove (Bluetooth)",
//                     gradientColors: const [Color(0xFFFFD700), Color(0xFFFFB700)],
//                     icon: Icons.bluetooth_connected,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const BLEConnectionScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   _buildNavButton(
//                     context,
//                     title: "🖐 Gesture Training",
//                     gradientColors: const [Color(0xFF14FFEC), Color(0xFF00C2FF)],
//                     icon: Icons.gesture,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const GestureTrainingScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   _buildNavButton(
//                     context,
//                     title: "🎙 Voice Assistant",
//                     gradientColors: const [Color(0xFFFC5C7D), Color(0xFF6A82FB)],
//                     icon: Icons.record_voice_over,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const VoiceAssistantScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   const Spacer(),

//                   // Footer credits
//                   Text(
//                     "Developed by Dhanushkumar Sekar\nState & National Award Winner 🏆",
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.poppins(
//                       color: Colors.white.withValues(alpha: 0.5),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavButton(
//     BuildContext context, {
//     required String title,
//     required List<Color> gradientColors,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: gradientColors,
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: gradientColors.last.withValues(alpha:0.4),
//               blurRadius: 12,
//               spreadRadius: 1,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: Colors.black, size: 26),
//             const SizedBox(width: 10),
//             Text(
//               title,
//               style: GoogleFonts.poppins(
//                 color: Colors.black,
//                 fontSize: 18,
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
// import 'package:google_fonts/google_fonts.dart';
// import 'ble_connection_screen.dart';
// import 'gesture_training_screen.dart';
// import 'voice_assistant_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: const Color(0xFF0D0D0D),
//       body: Stack(
//         children: [
//           // Background gradient glow
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color(0xFF0D0D0D),
//                   Color(0xFF1C1C1C),
//                   Color(0xFF0A0A0A),
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),

//           // Animated overlay glow
//           Positioned.fill(
//             child: Align(
//               alignment: Alignment.topCenter,
//               child: Opacity(
//                 opacity: 0.5,
//                 child: Lottie.asset(
//                   'assets/glovecom_ai.json',
//                   width: screenWidth * 0.9,
//                   repeat: true,
//                   fit: BoxFit.contain,
//                 ),
//               ),
//             ),
//           ),

//           // Main content
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Logo or Lottie intro
//                   Lottie.asset(
//                     'assets/ai_wave.json',
//                     width: 200,
//                     height: 200,
//                     repeat: true,
//                   ),
//                   const SizedBox(height: 20),

//                   // Title
//                   Text(
//                     "GloveCom",
//                     style: GoogleFonts.orbitron(
//                       fontSize: 42,
//                       fontWeight: FontWeight.bold,
//                       color: const Color(0xFFFFD700),
//                       letterSpacing: 2,
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   Text(
//                     "Sign Language → Speech & Text",
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.poppins(
//                       color: Colors.white.withValues(alpha: 0.8),

//                       fontSize: 16,
//                     ),
//                   ),
//                   const SizedBox(height: 60),

//                   // Buttons
//                   _buildNavButton(
//                     context,
//                     title: "🔗 Connect Glove (Bluetooth)",
//                     gradientColors: const [Color(0xFFFFD700), Color(0xFFFFB700)],
//                     icon: Icons.bluetooth_connected,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const BLEConnectionScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   _buildNavButton(
//                     context,
//                     title: "🖐 Gesture Training",
//                     gradientColors: const [Color(0xFF14FFEC), Color(0xFF00C2FF)],
//                     icon: Icons.gesture,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const GestureTrainingScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   const SizedBox(height: 20),
//                   _buildNavButton(
//                     context,
//                     title: "🎙 Voice Assistant",
//                     gradientColors: const [Color(0xFFFC5C7D), Color(0xFF6A82FB)],
//                     icon: Icons.record_voice_over,
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const VoiceAssistantScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   const Spacer(),

//                   // Footer credits
//                   Text(
//                     "Developed by Dhanushkumar Sekar\nState & National Award Winner 🏆",
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.poppins(
                      
// color: Colors.white.withValues(alpha: 0.5),

//                       fontSize: 12,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNavButton(
//     BuildContext context, {
//     required String title,
//     required List<Color> gradientColors,
//     required IconData icon,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(16),
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: gradientColors,
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
              
// color: gradientColors.last.withValues(alpha: 0.4),
//               blurRadius: 12,
//               spreadRadius: 1,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, color: Colors.black, size: 26),
//             const SizedBox(width: 10),
//             Text(
//               title,
//               style: GoogleFonts.poppins(
//                 color: Colors.black,
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ble_connection_screen.dart';
import 'gesture_training_screen.dart';
import 'voice_assistant_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Stack(
        children: [
          // 🌌 Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF0D0D0D),
                  Color(0xFF1C1C1C),
                  Color(0xFF0A0A0A),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // ✨ Animated overlay (AI theme)
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: Opacity(
                opacity: 0.5,
                child: Lottie.asset(
                  'assets/glovecom_ai.json',
                  width: screenWidth * 0.9,
                  repeat: true,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // 🧠 Main content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo animation
                  Lottie.asset(
                    'assets/ai_wave.json',
                    width: 200,
                    height: 200,
                    repeat: true,
                  ),
                  const SizedBox(height: 20),

                  // App Title
                  Text(
                    "GloveCom",
                    style: GoogleFonts.orbitron(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFFFD700),
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Subtitle
                  Text(
                    "Sign Language → Speech & Text",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white.withValues(alpha: 0.8),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 60),

                  // 🔗 Connect Glove
                  _buildNavButton(
                    context,
                    title: "🔗 Connect Glove (Bluetooth)",
                    gradientColors: const [Color(0xFFFFD700), Color(0xFFFFB700)],
                    icon: Icons.bluetooth_connected,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const BLEConnectionScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // 🖐 Gesture Training
                  _buildNavButton(
                    context,
                    title: "🖐 Gesture Training",
                    gradientColors: const [Color(0xFF14FFEC), Color(0xFF00C2FF)],
                    icon: Icons.gesture,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const GestureTrainingScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // 🎙 Voice Assistant
                  _buildNavButton(
                    context,
                    title: "🎙 Voice Assistant",
                    gradientColors: const [Color(0xFFFC5C7D), Color(0xFF6A82FB)],
                    icon: Icons.record_voice_over,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const VoiceAssistantScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),

                  // 🗣 Voice to Sentence (new)
                  _buildNavButton(
                    context,
                    title: "🗣 Voice to Sentence",
                    gradientColors: const [Color(0xFF6A82FB), Color(0xFFFC5C7D)],
                    icon: Icons.text_fields,
                    onTap: () {
                      Navigator.pushNamed(context, '/speech-sentence');
                    },
                  ),

                  const Spacer(),

                  // 👨‍💻 Footer credits
                  Text(
                    "Developed by Dhanushkumar Sekar\nState & National Award Winner 🏆",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 🎨 Reusable button widget
  Widget _buildNavButton(
    BuildContext context, {
    required String title,
    required List<Color> gradientColors,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withValues(alpha: 0.4),
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black, size: 26),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}