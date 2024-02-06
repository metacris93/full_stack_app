class BackendEndpoint {
  static const apiScheme = 'https';
  static const apiHost = '6121-157-100-112-16.ngrok-free.app';
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
