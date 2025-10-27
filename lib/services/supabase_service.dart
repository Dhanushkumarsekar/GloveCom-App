// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class SupabaseService {
//   static SupabaseClient? _client;
//   static SupabaseService? _instance;

//   SupabaseService._();

//   static SupabaseService get instance {
//     _instance ??= SupabaseService._();
//     return _instance!;
//   }

//   static Future<void> init() async {
//     final url = dotenv.env['SUPABASE_URL'] ?? '';
//     final key = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
//     _client = SupabaseClient(url, key);
//     _instance = SupabaseService._();
//   }

//   SupabaseClient get client {
//     if (_client == null) {
//       throw Exception('Supabase not initialized. Call SupabaseService.init() first.');
//     }
//     return _client!;
//   }

//   // gestures
//   Future<List<Map<String,dynamic>>> fetchGestures() async {
//     final res = await client.from('gestures').select().execute();
//     if (res.error != null) throw res.error!;
//     return List<Map<String,dynamic>>.from(res.data as List);
//   }

//   Future<void> insertGesture(Map<String,dynamic> gesture) async {
//     final res = await client.from('gestures').insert(gesture).execute();
//     if (res.error != null) throw res.error!;
//   }

//   Future<void> insertHistory(Map<String,dynamic> item) async {
//     await client.from('history').insert(item).execute();
//   }
// }




// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// class SupabaseService {
//   static SupabaseClient? _client;
//   static SupabaseService? _instance;

//   SupabaseService._();

//   static SupabaseService get instance {
//     _instance ??= SupabaseService._();
//     return _instance!;
//   }

//   /// Initialize Supabase client from .env
//   static Future<void> init() async {
//     final url = dotenv.env['SUPABASE_URL'] ?? '';
//     final key = dotenv.env['SUPABASE_ANON_KEY'] ?? '';

//     if (url.isEmpty || key.isEmpty) {
//       throw Exception('❌ Missing SUPABASE_URL or SUPABASE_ANON_KEY in .env');
//     }

//     _client = SupabaseClient(url, key);
//     _instance = SupabaseService._();
//   }

//   /// Returns initialized Supabase client
//   SupabaseClient get client {
//     if (_client == null) {
//       throw Exception('Supabase not initialized. Call SupabaseService.init() first.');
//     }
//     return _client!;
//   }

//   /// Fetch all gestures
//   Future<List<Map<String, dynamic>>> fetchGestures() async {
//     try {
//       final data = await client.from('gestures').select<List<Map<String, dynamic>>>();
//       return data;
//     } on PostgrestException catch (e) {
//       throw Exception('Supabase error: ${e.message}');
//     }
//   }

//   /// Insert a new gesture into database
//   Future<void> insertGesture(Map<String, dynamic> gesture) async {
//     try {
//       await client.from('gestures').insert(gesture);
//     } on PostgrestException catch (e) {
//       throw Exception('Insert gesture failed: ${e.message}');
//     }
//   }

//   /// Insert a new translation history record
//   Future<void> insertHistory(Map<String, dynamic> item) async {
//     try {
//       await client.from('history').insert(item);
//     } on PostgrestException catch (e) {
//       throw Exception('Insert history failed: ${e.message}');
//     }
//   }

//   /// Example: fetch recent history
//   Future<List<Map<String, dynamic>>> fetchHistory() async {
//     try {
//       final data = await client.from('history').select<List<Map<String, dynamic>>>().order('timestamp', ascending: false);
//       return data;
//     } on PostgrestException catch (e) {
//       throw Exception('Fetch history failed: ${e.message}');
//     }
//   }
// }



// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import '../constants.dart';

// class SupabaseService {
//   static SupabaseClient? _client;
//   static SupabaseService? _instance;

//   SupabaseService._();

//   static SupabaseService get instance {
//     _instance ??= SupabaseService._();
//     return _instance!;
//   }

//   static Future<void> init() async {
//     final url = dotenv.env['SUPABASE_URL'] ?? '';
//     final key = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
//     if (url.isEmpty || key.isEmpty) {
//       throw Exception('❌ Missing Supabase credentials in .env');
//     }
//     _client = SupabaseClient(url, key);
//     _instance = SupabaseService._();
//   }

//   SupabaseClient get client {
//     if (_client == null) {
//       throw Exception('Supabase not initialized. Call SupabaseService.init() first.');
//     }
//     return _client!;
//   }

//   Future<List<Map<String, dynamic>>> fetchGestures() async {
//     try {
//       final data = await client
//           .from(SUPABASE_GESTURES_TABLE)
//           .select<List<Map<String, dynamic>>>();
//       return data;
//     } on PostgrestException catch (e) {
//       throw Exception('❌ Supabase error: ${e.message}');
//     }
//   }

//   Future<void> insertGesture(Map<String, dynamic> gesture) async {
//     try {
//       await client.from(SUPABASE_GESTURES_TABLE).insert(gesture);
//     } on PostgrestException catch (e) {
//       throw Exception('❌ Insert gesture failed: ${e.message}');
//     }
//   }

//   Future<void> insertHistory(Map<String, dynamic> item) async {
//     try {
//       await client.from(SUPABASE_HISTORY_TABLE).insert(item);
//     } on PostgrestException catch (e) {
//       throw Exception('❌ Insert history failed: ${e.message}');
//     }
//   }

//   Future<List<Map<String, dynamic>>> fetchHistory() async {
//     try {
//       final data = await client
//           .from(SUPABASE_HISTORY_TABLE)
//           .select<List<Map<String, dynamic>>>()
//           .order('timestamp', ascending: false);
//       return data;
//     } on PostgrestException catch (e) {
//       throw Exception('❌ Fetch history failed: ${e.message}');
//     }
//   }
// }



import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../constants.dart';

class SupabaseService {
  static SupabaseClient? _client;
  static SupabaseService? _instance;

  SupabaseService._();

  static SupabaseService get instance {
    _instance ??= SupabaseService._();
    return _instance!;
  }

  // -------------------- INIT --------------------
  static Future<void> init() async {
    final url = dotenv.env['SUPABASE_URL'] ?? '';
    final key = dotenv.env['SUPABASE_ANON_KEY'] ?? '';
    if (url.isEmpty || key.isEmpty) {
      throw Exception('❌ Missing Supabase credentials in .env');
    }
    _client = SupabaseClient(url, key);
    _instance = SupabaseService._();
  }

  SupabaseClient get client {
    if (_client == null) {
      throw Exception('Supabase not initialized. Call SupabaseService.init() first.');
    }
    return _client!;
  }

  // -------------------- FETCH GESTURES --------------------
  Future<List<Map<String, dynamic>>> fetchGestures() async {
    try {
      final data = await client.from(SUPABASE_GESTURES_TABLE).select();
      return List<Map<String, dynamic>>.from(data);
    } on PostgrestException catch (e) {
      throw Exception('❌ Supabase error: ${e.message}');
    }
  }

  // -------------------- INSERT GESTURE --------------------
  Future<void> insertGesture(Map<String, dynamic> gesture) async {
    try {
      await client.from(SUPABASE_GESTURES_TABLE).insert(gesture);
    } on PostgrestException catch (e) {
      throw Exception('❌ Insert gesture failed: ${e.message}');
    }
  }

  // -------------------- INSERT HISTORY --------------------
  Future<void> insertHistory(Map<String, dynamic> item) async {
    try {
      await client.from(SUPABASE_HISTORY_TABLE).insert(item);
    } on PostgrestException catch (e) {
      throw Exception('❌ Insert history failed: ${e.message}');
    }
  }

  // -------------------- FETCH HISTORY --------------------
  Future<List<Map<String, dynamic>>> fetchHistory() async {
    try {
      final data = await client
          .from(SUPABASE_HISTORY_TABLE)
          .select()
          .order('timestamp', ascending: false);
      return List<Map<String, dynamic>>.from(data);
    } on PostgrestException catch (e) {
      throw Exception('❌ Fetch history failed: ${e.message}');
    }
  }
}
