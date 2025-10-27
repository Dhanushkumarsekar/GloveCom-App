// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../services/tts_service.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// class VoiceAssistantScreen extends StatefulWidget {
//   const VoiceAssistantScreen({super.key});

//   @override
//   State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
// }

// class _VoiceAssistantScreenState extends State<VoiceAssistantScreen> {
//   final _stt = stt.SpeechToText();
//   String _lastWords = '';
//   bool _listening = false;

//   Future<void> _toggleListen() async {
//     if (!_listening) {
//       bool available = await _stt.initialize();
//       if (available) {
//         setState(() => _listening = true);
//         _stt.listen(onResult: (result) {
//           setState(() { _lastWords = result.recognizedWords; });
//         });
//       }
//     } else {
//       _stt.stop();
//       setState(() => _listening = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final tts = Provider.of<TTSService>(context);
//     return Scaffold(
//       appBar: AppBar(title: const Text('Voice Assistant')),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             Text('Detected speech: $_lastWords'),
//             Row(
//               children: [
//                 ElevatedButton(onPressed: _toggleListen, child: Text(_listening ? 'Stop listening' : 'Start listening')),
//                 const SizedBox(width: 12),
//                 ElevatedButton(onPressed: () => tts.speak(_lastWords.isEmpty ? 'Hello' : _lastWords), child: const Text('Speak')),
//               ],
//             ),
//             const SizedBox(height: 12),
//             const Text('Tip: You can use voice-to-text to send messages or test TTS output.'),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter/foundation.dart';


// class VoiceAssistantScreen extends StatefulWidget {
//   const VoiceAssistantScreen({super.key});

//   @override
//   State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
// }

// class _VoiceAssistantScreenState extends State<VoiceAssistantScreen> {
//   late stt.SpeechToText _speech;
//   late FlutterTts _tts;
//   bool _isListening = false;
//   String _recognizedText = "Tap the mic to start speaking";

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//     _tts = FlutterTts();
//   }

//   Future<void> _listen() async {
//     if (!_isListening) {
//       bool available = await _speech.initialize(
//         debugPrint('🎙 Status: $val');
        
//         debugPrint('🎙 Status: Error: $val');
//       );
//       if (available) {
//         setState(() => _isListening = true);
//         _speech.listen(onResult: (val) {
//           setState(() {
//             _recognizedText = val.recognizedWords;
//           });
//         });
//       }
//     } else {
//       setState(() => _isListening = false);
//       _speech.stop();
//     }
//   }

//   Future<void> _speak(String text) async {
//     await _tts.speak(text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text("Voice Assistant"),
//         backgroundColor: const Color(0xFFD4AF37),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               _recognizedText,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 22,
//               ),
//             ),
//             const SizedBox(height: 40),
//             FloatingActionButton(
//               backgroundColor: _isListening ? Colors.red : const Color(0xFFD4AF37),
//               onPressed: _listen,
//               child: Icon(
//                 _isListening ? Icons.stop : Icons.mic,
//                 color: Colors.black,
//                 size: 30,
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: () => _speak(_recognizedText),
//               icon: const Icon(Icons.volume_up),
//               label: const Text("Speak"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class VoiceAssistantScreen extends StatefulWidget {
  const VoiceAssistantScreen({super.key});

  @override
  State<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends State<VoiceAssistantScreen> {
  late stt.SpeechToText _speech;
  late FlutterTts _tts;
  bool _isListening = false;
  String _recognizedText = "Tap the mic to start speaking";

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _tts = FlutterTts();
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          debugPrint('🎙 Status: $status');
        },
        onError: (error) {
          debugPrint('❌ Error: ${error.errorMsg}');
        },
      );

      if (available) {
        setState(() => _isListening = true);
        _speech.listen(onResult: (result) {
          setState(() {
            _recognizedText = result.recognizedWords;
          });
        });
      } else {
        debugPrint("⚠ Speech recognition unavailable");
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future<void> _speak(String text) async {
    if (text.isNotEmpty) {
      await _tts.speak(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Voice Assistant"),
        backgroundColor: const Color(0xFFD4AF37),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _recognizedText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
            const SizedBox(height: 40),
            FloatingActionButton(
              backgroundColor:
                  _isListening ? Colors.red : const Color(0xFFD4AF37),
              onPressed: _listen,
              child: Icon(
                _isListening ? Icons.stop : Icons.mic,
                color: Colors.black,
                size: 30,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _speak(_recognizedText),
              icon: const Icon(Icons.volume_up),
              label: const Text("Speak"),
            ),
          ],
        ),
      ),
    );
  }
}