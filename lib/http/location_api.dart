import 'dart:convert';

import 'package:full_stack_app/http/location_endpoint.dart';
import 'package:full_stack_app/models/location.dart';
import 'package:http/http.dart';

class LocationApi {
  final Client httpClient;

  LocationApi({required this.httpClient});

  Future<List<Location>> fetchLocation() async {
    var url = LocationEndpoint.uri('locations');
    final res = await httpClient.get(url);
    if (res.statusCode != 200) {
      throw res.body;
    }
    List<Location> list = [];
    for (var item in json.decode(res.body)) {
      list.add(Location.fromJson(item));
    }
    return list;
  }
}
