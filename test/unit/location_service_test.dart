import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:full_stack_app/database/dao/user_dao.dart';
import 'package:full_stack_app/database/database.dart';
// import 'package:full_stack_app/helpers/general.dart';
import 'package:full_stack_app/helpers/provider_global.dart';
import 'package:full_stack_app/http/auth_interceptor.dart';
import 'package:full_stack_app/http/backend_endpoint.dart';
import 'package:full_stack_app/http/services/location_api_service.dart';
import 'package:full_stack_app/models/user_location.dart';
import 'package:http_interceptor/http_interceptor.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../general_test.dart';
import 'location_service_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {
  late MockClient client;
  late Uri uri;

  setUpAll(() async {
    sqfliteFfiInit();
    client = MockClient();
    uri = BackendEndpoint.uri('user/location');
  });
  group('LOCATION API SERVICE FUNCTIONS', () {
    test('It can save user current location', () async {
      final db = await mockInMemoryDatabase([
        UserDao().createTableQuery,
      ]);
      const jsonString = """
{
  "succeeded": true,
  "message": "Location saved successfully",
  "errors": [],
  "data": null
}
  """;
      final container = ProviderContainer(overrides: [
        databaseProvider.overrideWithValue(DBProvider.instance),
      ]);
      final userRepository = container.read(userRepositoryProvider);
      var userLoggedIn = await insertDefaultUser(userRepository);
      var userLocation = UserLocation(latitude: 0.0, longitude: 0.0);

      var httpMockClient = InterceptedHttp.build(interceptors: [
        AuthInterceptor(userLoggedIn.token),
      ], client: client);
      when(httpMockClient.client!
              .post(uri, body: jsonEncode(userLocation.toJson())))
          .thenAnswer((_) async => http.Response(jsonString, 200));
      var locationApi = LocationApiService(
          httpClient: client, userRepository: userRepository);
      var response = await locationApi.saveCurrentLocation(userLocation);
      expect(response.succeeded, true);
      expect(response.message, 'Location saved successfully');
      expect(response.errors, []);
      expect(response.data, null);
      await db.close();
    });
  });
}
