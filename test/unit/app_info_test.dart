import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:full_stack_app/http/api_response.dart';
import 'package:full_stack_app/http/backend_api.dart';
import 'package:full_stack_app/http/backend_endpoint.dart';
import 'package:full_stack_app/models/app_info.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_info_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient client;
  late BackendApi backendApi;
  late Uri uriAppInfo;

  setUp(() {
    client = MockClient();
    backendApi = BackendApi(httpClient: client);
    uriAppInfo = BackendEndpoint.uri('info');
  });
  group('APP INFO FUNCTIONS', () {
    test('AppInfo can be fetched', () async {
      const jsonString = """
{
  "succeeded": true,
  "message": "",
  "errors": [],
  "data": {
    "name": "Full Stack App",
    "version": "1.0.0"
  }
}
  """;
      // arrange
      when(client.get(uriAppInfo))
          .thenAnswer((_) async => http.Response(jsonString, 200));
      // act
      final result = await backendApi.fetchAppInfo();
      // assert
      final jsonRes = jsonDecode(jsonString) as Map<String, dynamic>;
      final apiResponse =
          ApiResponse<AppInfo>.fromJson(jsonRes, AppInfo.fromJson);
      expect(result.succeeded, apiResponse.succeeded);
      expect(result.message, apiResponse.message);
      expect(result.errors, apiResponse.errors);
      expect(result.data!.name, apiResponse.data!.name);
      expect(result.data!.version, apiResponse.data!.version);
      verify(client.get(uriAppInfo));
    });
  });
}
