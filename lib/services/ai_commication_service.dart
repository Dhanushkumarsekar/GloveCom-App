// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter/foundation.dart';

// class AICommunicationService extends ChangeNotifier {
//   final FlutterTts _tts = FlutterTts();
//   final stt.SpeechToText _speech = stt.SpeechToText();

//   bool isListening = false;
//   bool isSpeaking = false;

//   String spokenText = "";
//   String finalSentence = "";

//   /// 🔊 Speak text aloud
//   Future<void> speak(String text) async {
//     if (text.isEmpty) return;
//     isSpeaking = true;
//     notifyListeners();

//     await _tts.setLanguage("en-IN");
//     await _tts.setPitch(1.0);
//     await _tts.setSpeechRate(0.9);
//     await _tts.speak(text);

//     _tts.setCompletionHandler(() {
//       isSpeaking = false;
//       notifyListeners();
//     });
//   }

//   /// 🎙 Start listening and converting voice → text
//   Future<void> startListening() async {
//     if (isListening) {
//       await _speech.stop();
//       isListening = false;
//       notifyListeners();
//       return;
//     }

//     bool available = await _speech.initialize(
//       onStatus: (status) {
//         if (status == "done") {
//           isListening = false;
//           notifyListeners();
//         }
//       },
//       onError: (err) {
//         debugPrint("❌ Speech error: $err");
//         isListening = false;
//         notifyListeners();
//       },
//     );

//     if (available) {
//       isListening = true;
//       notifyListeners();

//       _speech.listen(
//         onResult: (result) {
//           spokenText = result.recognizedWords;
//           if (result.finalResult) {
//             finalSentence +=
//                 (finalSentence.isEmpty ? "" : " ") + spokenText;
//             spokenText = "";
//           }
//           notifyListeners();
//         },
//         listenOptions: stt.SpeechListenOptions(
//           listenMode: stt.ListenMode.dictation,
//           partialResults: true,
//         ),
//       );
//     }
//   }

//   Future<void> stopListening() async {
//     await _speech.stop();
//     isListening = false;
//     notifyListeners();
//   }

//   void clearText() {
//     spokenText = "";
//     finalSentence = "";
//     notifyListeners();
//   }

//   @override
//   void dispose() {
//     _tts.stop();
//     _speech.stop();
//     super.dispose();
//   }
// }


import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class AICommunicationService extends ChangeNotifier {
  final FlutterTts _tts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  bool isListening = false;
  bool isSpeaking = false;

  String spokenText = "";
  String finalSentence = "";

  /// 🔊 Speak text aloud
  Future<void> speak(String text) async {
    if (text.isEmpty) return;
    isSpeaking = true;
    notifyListeners();

    await _tts.setLanguage("en-IN");
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.9);
    await _tts.speak(text);

    _tts.setCompletionHandler(() {
      isSpeaking = false;
      notifyListeners();
    });
  }

  /// 🎙 Start listening (voice → text)
  Future<void> startListening() async {
    if (isListening) {
      await _speech.stop();
      isListening = false;
      notifyListeners();
      return;
    }

    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == "done") {
          isListening = false;
          notifyListeners();
        }
      },
      onError: (err) {
        debugPrint("❌ Speech error: $err");
        isListening = false;
        notifyListeners();
      },
    );

    if (available) {
      isListening = true;
      notifyListeners();

      _speech.listen(
        onResult: (result) {
          spokenText = result.recognizedWords;
          if (result.finalResult) {
            finalSentence +=
                (finalSentence.isEmpty ? "" : " ") + spokenText;
            spokenText = "";
          }
          notifyListeners();
        },
        listenOptions: stt.SpeechListenOptions(
          listenMode: stt.ListenMode.dictation,
          partialResults: true,
        ),
      );
    }
  }

  Future<void> stopListening() async {
    await _speech.stop();
    isListening = false;
    notifyListeners();
  }

  void clearText() {
    spokenText = "";
    finalSentence = "";
    notifyListeners();
  }

  @override
  void dispose() {
    _tts.stop();
    _speech.stop();
    super.dispose();
  }
}
