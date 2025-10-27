// // lib/utils/flutter_blue_plus_license.dart
// import 'package:flutter/foundation.dart';

// /// ✅ This class mimics the real License class expected by flutter_blue_plus
// @immutable
// class License {
//   final String organization;
//   final String key;

//   const License({
//     required this.organization,
//     required this.key,
//   });

//   @override
//   String toString() => 'License(organization: $organization, key: $key)';
// }



// import 'package:flutter/foundation.dart';

// @immutable
// class License {
//   final String organization;
//   final String key;

//   const License({
//     required this.organization,
//     required this.key,
//   });
  
// }


import 'package:flutter/foundation.dart';

@immutable
class License {
  final String organization;
  final String key;

  const License({
    required this.organization,
    required this.key,
  });
}
