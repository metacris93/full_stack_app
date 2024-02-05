import 'dart:convert';

import 'package:full_stack_app/http/api_response.dart';
import 'package:full_stack_app/http/backend_endpoint.dart';
import 'package:full_stack_app/models/app_info.dart';
import 'package:full_stack_app/models/login.dart';
import 'package:full_stack_app/models/user_sign_in.dart';
import 'package:http/http.dart';

class BackendApi {
  final Client httpClient;

  BackendApi({required this.httpClient});

  Future<ApiResponse<UserSignIn>> login(Login login) async {
    Map<String, dynamic> data = login.toJson();
    var url = BackendEndpoint.uri('login');
    final res = await httpClient.post(url, body: jsonEncode(data));
    if (res.statusCode != 200) {
      throw res.body;
    }
    final jsonRes = jsonDecode(res.body) as Map<String, dynamic>;
    return ApiResponse<UserSignIn>.fromJson(jsonRes, UserSignIn.fromJson);
  }

  Future<ApiResponse<AppInfo>> fetchAppInfo() async {
    var url = BackendEndpoint.uri('info');
    final res = await httpClient.get(url);
    if (res.statusCode != 200) {
      throw res.body;
    }
    final jsonRes = jsonDecode(res.body) as Map<String, dynamic>;
    return ApiResponse<AppInfo>.fromJson(jsonRes, AppInfo.fromJson);
  }
}
