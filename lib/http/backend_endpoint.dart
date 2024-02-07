class BackendEndpoint {
  static const apiScheme = 'https';
  static const apiHost = 'db02-157-100-104-67.ngrok-free.app';
  static const prefix = '/api/v1/';

  static Uri uri(String path, {Map<String, dynamic>? queryParameters}) {
    return Uri(
      scheme: apiScheme,
      host: apiHost,
      path: '$prefix$path',
      // port: 8000,
      queryParameters: queryParameters,
    );
  }
}
