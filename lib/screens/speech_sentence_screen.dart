// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/services.dart';

// class SpeechSentenceScreen extends StatefulWidget {
//   const SpeechSentenceScreen({super.key});

//   @override
//   State<SpeechSentenceScreen> createState() => _SpeechSentenceScreenState();
// }

// class _SpeechSentenceScreenState extends State<SpeechSentenceScreen> {
//   final stt.SpeechToText _speech = stt.SpeechToText();
//   bool _isListening = false;
//   String _recognizedWords = "";
//   String _finalSentence = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0D0D0D),
//       appBar: AppBar(
//         title: const Text(
//           "Voice to Sentence Builder",
//           style: TextStyle(
//             color: Color(0xFFFFD700),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         iconTheme: const IconThemeData(color: Color(0xFFFFD700)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 40),

//             // 🎙 Microphone button
//             GestureDetector(
//               onTap: _listen,
//               child: CircleAvatar(
//                 radius: 55,
//                 backgroundColor: _isListening
//                     ? const Color(0xFFFFD700)
//                     : Colors.grey.shade800,
//                 child: Icon(
//                   _isListening ? Icons.mic : Icons.mic_none,
//                   color: _isListening ? Colors.black : Colors.white,
//                   size: 48,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),

//             // 🔠 Live words
//             Text(
//               _recognizedWords.isNotEmpty
//                   ? _recognizedWords
//                   : "Tap the mic & start speaking...",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: 20,
//                 color: _isListening
//                     ? const Color(0xFFFFD700)
//                     : Colors.white70,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 50),

//             // 🧠 Final sentence
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF1C1C1C), Color(0xFF0A0A0A)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: const Color(0xFFFFD700), width: 1),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Text(
//                     _finalSentence.isEmpty
//                         ? "🧩 Your complete sentence will appear here."
//                         : _finalSentence,
//                     style: GoogleFonts.orbitron(
//                       fontSize: 18,
//                       color: Colors.white,
//                       height: 1.5,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),

//             // 🧭 Buttons row
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildButton(
//                   icon: Icons.cleaning_services,
//                   label: "Clear",
//                   color: Colors.redAccent,
//                   onTap: () {
//                     setState(() {
//                       _recognizedWords = "";
//                       _finalSentence = "";
//                     });
//                   },
//                 ),
//                 _buildButton(
//                   icon: Icons.copy,
//                   label: "Copy",
//                   color: const Color(0xFFFFD700),
//                   onTap: () {
//                     Clipboard.setData(
//                         ClipboardData(text: _finalSentence));
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Sentence copied to clipboard!"),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🎙 Voice Recognition
//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (val) {
//           if (val == 'done') {
//             setState(() => _isListening = false);
//           }
//         },
//         onError: (val) {
//           debugPrint('Speech error: $val');
//           setState(() => _isListening = false);
//         },
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(
//           onResult: (val) {
//             setState(() {
//               _recognizedWords = val.recognizedWords;
//               if (val.finalResult) {
//                 _finalSentence +=
//                     (_finalSentence.isEmpty ? "" : " ") + _recognizedWords;
//                 _recognizedWords = "";
//               }
//             });
//           },
//           listenMode: stt.ListenMode.confirmation,
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   // 🧭 Custom reusable button
//   Widget _buildButton({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         foregroundColor: Colors.black,
//         padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       onPressed: onTap,
//       icon: Icon(icon, size: 22),
//       label: Text(
//         label,
//         style: const TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter/services.dart';

// class SpeechSentenceScreen extends StatefulWidget {
//   const SpeechSentenceScreen({super.key});

//   @override
//   State<SpeechSentenceScreen> createState() => _SpeechSentenceScreenState();
// }

// class _SpeechSentenceScreenState extends State<SpeechSentenceScreen> {
//   final stt.SpeechToText _speech = stt.SpeechToText();
//   bool _isListening = false;
//   String _recognizedWords = "";
//   String _finalSentence = "";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0D0D0D),
//       appBar: AppBar(
//         title: const Text(
//           "Voice to Sentence Builder",
//           style: TextStyle(
//             color: Color(0xFFFFD700),
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.black,
//         iconTheme: const IconThemeData(color: Color(0xFFFFD700)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           children: [
//             const SizedBox(height: 40),

//             // 🎙 Mic Button
//             GestureDetector(
//               onTap: _listen,
//               child: CircleAvatar(
//                 radius: 55,
//                 backgroundColor:
//                     _isListening ? const Color(0xFFFFD700) : Colors.grey.shade800,
//                 child: Icon(
//                   _isListening ? Icons.mic : Icons.mic_none,
//                   color: _isListening ? Colors.black : Colors.white,
//                   size: 48,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),

//             // 🎧 Current recognized words
//             Text(
//               _recognizedWords.isNotEmpty
//                   ? _recognizedWords
//                   : "Tap the mic & start speaking...",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                 fontSize: 20,
//                 color: _isListening
//                     ? const Color(0xFFFFD700)
//                     : Colors.white70,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//             const SizedBox(height: 50),

//             // 🧠 Final sentence output
//             Expanded(
//               child: Container(
//                 width: double.infinity,
//                 padding: const EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   gradient: const LinearGradient(
//                     colors: [Color(0xFF1C1C1C), Color(0xFF0A0A0A)],
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                   ),
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: const Color(0xFFFFD700), width: 1),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Text(
//                     _finalSentence.isEmpty
//                         ? "🧩 Your complete sentence will appear here."
//                         : _finalSentence,
//                     style: GoogleFonts.orbitron(
//                       fontSize: 18,
//                       color: Colors.white,
//                       height: 1.5,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30),

//             // 🧭 Control buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _buildButton(
//                   icon: Icons.cleaning_services,
//                   label: "Clear",
//                   color: Colors.redAccent,
//                   onTap: () {
//                     setState(() {
//                       _recognizedWords = "";
//                       _finalSentence = "";
//                     });
//                   },
//                 ),
//                 _buildButton(
//                   icon: Icons.copy,
//                   label: "Copy",
//                   color: const Color(0xFFFFD700),
//                   onTap: () {
//                     Clipboard.setData(ClipboardData(text: _finalSentence));
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(
//                         content: Text("Sentence copied to clipboard!"),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // 🎙 Voice listening logic (modern version)
//   void _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         onStatus: (val) {
//           if (val == 'done') setState(() => _isListening = false);
//         },
//         onError: (val) {
//           debugPrint('Speech error: $val');
//           setState(() => _isListening = false);
//         },
//       );

//       if (available) {
//         setState(() => _isListening = true);

//         _speech.listen(
//           onResult: (val) {
//             setState(() {
//               _recognizedWords = val.recognizedWords;
//               if (val.finalResult) {
//                 _finalSentence +=
//                     (_finalSentence.isEmpty ? "" : " ") + _recognizedWords;
//                 _recognizedWords = "";
//               }
//             });
//           },
//           listenOptions: stt.SpeechListenOptions(
//             listenMode: stt.ListenMode.dictation,
//             partialResults: true,
//           ),
//         );
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   // 🎨 Reusable button builder
//   Widget _buildButton({
//     required IconData icon,
//     required String label,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return ElevatedButton.icon(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color,
//         foregroundColor: Colors.black,
//         padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//       ),
//       onPressed: onTap,
//       icon: Icon(icon, size: 22),
//       label: Text(
//         label,
//         style: const TextStyle(fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../services/ai_commication_service.dart';

class SpeechSentenceScreen extends StatelessWidget {
  const SpeechSentenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ai = Provider.of<AICommunicationService>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        title: const Text(
          "Voice to Sentence Builder",
          style: TextStyle(color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFFFFD700)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 40),
            GestureDetector(
              onTap: () => ai.startListening(),
              child: CircleAvatar(
                radius: 55,
                backgroundColor: ai.isListening
                    ? const Color(0xFFFFD700)
                    : Colors.grey.shade800,
                child: Icon(
                  ai.isListening ? Icons.mic : Icons.mic_none,
                  color: ai.isListening ? Colors.black : Colors.white,
                  size: 48,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              ai.spokenText.isNotEmpty
                  ? ai.spokenText
                  : "Tap mic & start speaking...",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 20,
                color: ai.isListening
                    ? const Color(0xFFFFD700)
                    : Colors.white70,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1C1C1C), Color(0xFF0A0A0A)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFFFD700), width: 1),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    ai.finalSentence.isEmpty
                        ? "🧩 Your complete sentence will appear here."
                        : ai.finalSentence,
                    style: GoogleFonts.orbitron(
                      fontSize: 18,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton("Clear", Icons.cleaning_services, Colors.redAccent,
                    () => ai.clearText()),
                _buildButton("Copy", Icons.copy, const Color(0xFFFFD700), () {
                  Clipboard.setData(ClipboardData(text: ai.finalSentence));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Sentence copied!")),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, IconData icon, Color color, VoidCallback onTap) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onTap,
      icon: Icon(icon, size: 22),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
