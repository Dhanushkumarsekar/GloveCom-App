// import 'package:flutter/material.dart';
// import '../services/supabase_service.dart';

// class SpeechHistoryScreen extends StatefulWidget {
//   const SpeechHistoryScreen({super.key});

//   @override
//   State<SpeechHistoryScreen> createState() => _SpeechHistoryScreenState();
// }

// class _SpeechHistoryScreenState extends State<SpeechHistoryScreen> {
//   List<Map<String,dynamic>> _items = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadHistory();
//   }

//   Future<void> _loadHistory() async {
//     final svc = SupabaseService.instance;
//     final res = await svc.client.from('history').select().order('timestamp', ascending: false).execute();
//     if (res.error == null) {
//       setState(() {
//         _items = List<Map<String,dynamic>>.from(res.data as List);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Speech History')),
//       body: ListView.builder(
//         itemCount: _items.length,
//         itemBuilder: (_, i) {
//           final it = _items[i];
//           return ListTile(
//             title: Text(it['gesture_name'] ?? ''),
//             subtitle: Text(it['translated_text'] ?? ''),
//             trailing: Text(it['timestamp']?.toString() ?? ''),
//           );
//         },
//       ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import '../services/supabase_service.dart';

// class SpeechHistoryScreen extends StatefulWidget {
//   const SpeechHistoryScreen({super.key});

//   @override
//   State<SpeechHistoryScreen> createState() => _SpeechHistoryScreenState();
// }

// class _SpeechHistoryScreenState extends State<SpeechHistoryScreen> {
//   List<Map<String, dynamic>> _items = [];
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _loadHistory();
//   }

//   Future<void> _loadHistory() async {
//     try {
//       final svc = SupabaseService.instance;
//       final data = await svc.client
//           .from('history')
//           .select<List<Map<String, dynamic>>>()
//           .order('timestamp', ascending: false);

//       setState(() {
//         _items = data;
//         _isLoading = false;
//       });
//     } on PostgrestException catch (e) {
//       setState(() {
//         _errorMessage = e.message;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = e.toString();
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Speech History')),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _errorMessage != null
//               ? Center(child: Text('Error: $_errorMessage'))
//               : _items.isEmpty
//                   ? const Center(child: Text('No history found.'))
//                   : ListView.builder(
//                       itemCount: _items.length,
//                       itemBuilder: (_, i) {
//                         final it = _items[i];
//                         return Card(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 6),
//                           child: ListTile(
//                             title: Text(it['gesture_name'] ?? ''),
//                             subtitle: Text(it['translated_text'] ?? ''),
//                             trailing: Text(
//                               it['timestamp']?.toString().substring(0, 19) ??
//                                   '',
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//     );
//   }
// }



// import 'package:flutter/material.dart';
// import 'package:postgrest/postgrest.dart'; // ✅ Add this import
// import '../services/supabase_service.dart';

// class SpeechHistoryScreen extends StatefulWidget {
//   const SpeechHistoryScreen({super.key});

//   @override
//   State<SpeechHistoryScreen> createState() => _SpeechHistoryScreenState();
// }

// class _SpeechHistoryScreenState extends State<SpeechHistoryScreen> {
//   List<Map<String, dynamic>> _items = [];
//   bool _isLoading = true;
//   String? _errorMessage;

//   @override
//   void initState() {
//     super.initState();
//     _loadHistory();
//   }

//   Future<void> _loadHistory() async {
//     try {
//       final svc = SupabaseService.instance;
//       final data = await svc.client
//           .from('history')
//           .select<List<Map<String, dynamic>>>()
//           .order('timestamp', ascending: false);

//       setState(() {
//         _items = data;
//         _isLoading = false;
//       });
//     } on PostgrestException catch (e) {
//       setState(() {
//         _errorMessage = e.message;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = e.toString();
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Speech History')),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : _errorMessage != null
//               ? Center(child: Text('Error: $_errorMessage'))
//               : _items.isEmpty
//                   ? const Center(child: Text('No history found.'))
//                   : ListView.builder(
//                       itemCount: _items.length,
//                       itemBuilder: (_, i) {
//                         final it = _items[i];
//                         return Card(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 6),
//                           child: ListTile(
//                             title: Text(it['gesture_name'] ?? ''),
//                             subtitle: Text(it['translated_text'] ?? ''),
//                             trailing: Text(
//                               it['timestamp']?.toString().substring(0, 19) ??
//                                   '',
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

class SpeechHistoryScreen extends StatefulWidget {
  const SpeechHistoryScreen({super.key});

  @override
  State<SpeechHistoryScreen> createState() => _SpeechHistoryScreenState();
}

class _SpeechHistoryScreenState extends State<SpeechHistoryScreen> {
  List<Map<String, dynamic>> _items = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final svc = SupabaseService.instance;
      final data = await svc.client
          .from('history')
          .select()
          .order('timestamp', ascending: false);

      setState(() {
        _items = List<Map<String, dynamic>>.from(data);
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Speech History')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text('Error: $_errorMessage'))
              : _items.isEmpty
                  ? const Center(child: Text('No history found.'))
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (_, i) {
                        final it = _items[i];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          child: ListTile(
                            title: Text(it['gesture_name'] ?? ''),
                            subtitle: Text(it['translated_text'] ?? ''),
                            trailing: Text(
                              (it['timestamp'] ?? '').toString().substring(0, 19),
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
