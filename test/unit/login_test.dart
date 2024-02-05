import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:full_stack_app/database/dao/user_dao.dart';
import 'package:full_stack_app/database/database.dart';
import 'package:full_stack_app/database/repositories/user_repository.dart';
import 'package:full_stack_app/helpers/provider_global.dart';
import 'package:full_stack_app/http/api_response.dart';
import 'package:full_stack_app/http/backend_api.dart';
import 'package:full_stack_app/http/backend_endpoint.dart';
import 'package:full_stack_app/models/login.dart';
import 'package:full_stack_app/models/user_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'login_test.mocks.dart';

@GenerateMocks([http.Client])
void main() async {
  // TestWidgetsFlutterBinding.ensureInitialized();

  late MockClient client;
  late BackendApi backendApi;
  late Uri uriSignIn;
  late Login loginData;

  setUpAll(() async {
    sqfliteFfiInit();
    client = MockClient();
    backendApi = BackendApi(httpClient: client);
    uriSignIn = BackendEndpoint.uri('login');
    loginData = Login(username: 'user_test', password: 'password');
  });

  group('USER AUTHENTICATION FUNCTIONS', () {
    test('User can sign in', () async {
      const jsonString = """
{
  "succeeded": true,
  "message": "",
  "errors": [],
  "data": {
    "name": "Genevieve Harris Jr.",
    "username": "user_test",
    "email": "user_test@example.com",
    "api_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMWJkMmY4NTc4NThjYjI1NmU1OGYwM2U3NzdjZDY4OTYxN2JkMGQ2MjY3NzQ3ZTQ1NzYzOGEwMzQzZTIzMTcwZWQ3NmUyNjM0ZTU1YjJkOWQiLCJpYXQiOjE3MDcxMDUyODguMzk0ODU2LCJuYmYiOjE3MDcxMDUyODguMzk0ODU5LCJleHAiOjE3MTQ4ODEyODguMzQ4MTY2LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.JC9fmU4xf2EnF7BhBV0wV-fjUxXtjL9Hz6P-RyoUq0LdR79fJBcCaEnL2CdLyFeKV-SyuKF7TXf058Mrmgx8d5c6l3Vq8X5ziz8FyE_NTkLj6SbmYNrqIFPZK7Nfhnc4x-rmCYiu3dL5VMcUT261iDU5Hg9Fa79R1a4fDtYa2YHUi5TmM8yP-O689KWSHsAeRuIUy-bFg-fgifzeQhjfh12amR5Q9OUjE3pljwfXjySH2w1RczVYjNRR7QA_yP8hWYIGye7aaDrz29D60NmkBYiX_M-YaTrxi7ol2nUzOGSIgUfcuqwFVn0mqU8EALplUY8Xvot6wwKO-2Nz6zqhlITeXHRuQh_FLzEJ0mJ1Tu5sb2AcMN5MqdW53BBe4GwFgjkvqLwEEIk5QM_PbpiZYjgOTiQjQaMqxJzU8dweSRiQAXfC7C4KGCSLLrj9aiA6L6wofVZJyc49Rqxl52CYLjH2bUhY1-EiYy0Q7s-VKa0M63v5y8WIcKhJlaehsJmo8D718zcC_R0RY6qajFtitP9c_jOF5AuUvElAdqicEBA5FPgyMAUKMHlA2AwoUaQeKONp-sjlJO_1xdSMADQWsbYXKr-9rppdMpv3rQtXhwARhthJh9JHb6I60QNbnfBJ7maD_0caaSDCaap3NdMzwUvsI1_RAxOyKR5WRz8CwwM"
  }
}
  """;
      // arrange
      when(client.post(uriSignIn, body: jsonEncode(loginData.toJson())))
          .thenAnswer((_) async => http.Response(jsonString, 200));
      // act
      final result = await backendApi.login(loginData);
      // assert
      final jsonRes = jsonDecode(jsonString) as Map<String, dynamic>;
      final apiResponse =
          ApiResponse<UserSignIn>.fromJson(jsonRes, UserSignIn.fromJson);
      expect(result.succeeded, apiResponse.succeeded);
      expect(result.message, apiResponse.message);
      expect(result.errors, apiResponse.errors);
      expect(result.data!.name, apiResponse.data!.name);
      expect(result.data!.username, apiResponse.data!.username);
      expect(result.data!.email, apiResponse.data!.email);
      expect(result.data!.token, apiResponse.data!.token);
      verify(client.post(uriSignIn, body: jsonEncode(loginData.toJson())));
    });
    test('It can save user on database', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
      await db.execute(UserDao().createTableQuery);

      DBProvider.instance.setDatabase(db);
      final container = ProviderContainer(overrides: [
        databaseProvider.overrideWithValue(DBProvider.instance),
        // userRepositoryProvider
        //     .overrideWithValue(UserRepository(dbProvider: DBProvider.instance)),
      ]);

      final userRepository = container.read(userRepositoryProvider);
      final user = UserSignIn(
        username: 'test_username',
        name: 'test_name',
        email: 'test_email',
        token: 'test_token',
      );
      await userRepository.insert(user);
      var userRegistered = await userRepository.fetchById(1);
      expect(userRegistered.username, user.username);

      await db.close();
    });
  });
}
