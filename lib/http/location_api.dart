import 'dart:convert';

import 'package:full_stack_app/http/endpoint.dart';
import 'package:full_stack_app/models/location.dart';
import 'package:http/http.dart' as http;

class LocationApi {
  Future<List<Location>> fetchLocation() async {
    var uri = Endpoint.uri('locations');
    final res = await http.get(uri);
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
