import 'dart:convert';

import 'package:full_stack_app/database/repositories/user_repository.dart';
import 'package:full_stack_app/helpers/general.dart';
import 'package:full_stack_app/http/api_response.dart';
import 'package:full_stack_app/http/backend_endpoint.dart';
import 'package:full_stack_app/models/user_location.dart';
import 'package:http/http.dart';

class LocationApiService {
  final Client httpClient;
  final UserRepository userRepository;

  LocationApiService({required this.httpClient, required this.userRepository});

  Future<ApiResponse<Map<String, dynamic>?>> saveCurrentLocation(
      UserLocation userLocation) async {
    var url = BackendEndpoint.uri('user/location');
    var user = await userRepository.getCurrentUser();
    if (user == null) {
      throw 'User not found';
    }
    final res = await httpClient.post(
      url,
      body: jsonEncode(userLocation.toJson()),
    );
    if (res.statusCode != 200) {
      throw res.body;
    }
    final jsonRes = jsonDecode(res.body) as Map<String, dynamic>;
    return ApiResponse<Map<String, dynamic>>.fromJsonWithoutData(jsonRes);
  }
}
