class Endpoint {
  // https://api.fluttercrashcourse.com/api/v1/locations
  static const apiScheme = 'https';
  static const apiHost = 'api.fluttercrashcourse.com';
  static const prefix = '/api/v1/';

  static Uri uri(String path, {Map<String, dynamic>? queryParameters}) {
    return Uri(
      scheme: apiScheme,
      host: apiHost,
      path: '$prefix$path',
      queryParameters: queryParameters,
    );
  }
}
