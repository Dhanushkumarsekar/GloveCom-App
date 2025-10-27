/// This mimics the License API used in flutter_blue_plus beta versions.
/// You can use this if your package import is missing flutter_blue_plus_license.dart.
library;

class License {
  /// The organization or app name using the Bluetooth feature.
  final String organization;

  /// The license key (any unique identifier string for your app/project).
  final String key;

  const License({
    required this.organization,
    required this.key,
  });
}
