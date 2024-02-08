import 'package:full_stack_app/database/dao/dao.dart';
import 'package:full_stack_app/models/user_location_request.dart';

class UserLocationDao extends Dao<UserLocationRequest> {
  final tableName = 'user_location';
  final columnId = 'id';
  final columnUUID = 'uuid';
  final columnLatitude = 'latitude';
  final columnLongitude = 'longitude';
  final columnTimestamp = 'timestamp';

  @override
  String get createTableQuery => '''
      CREATE TABLE $tableName(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnUUID TEXT NOT NULL,
        $columnLatitude REAL NOT NULL,
        $columnLongitude REAL NOT NULL,
        $columnTimestamp TEXT
      )
    ''';

  @override
  List<UserLocationRequest> fromList(List<Map<String, dynamic>> query) {
    List<UserLocationRequest> users = List<UserLocationRequest>.empty();
    for (var map in query) {
      users.add(fromMap(map));
    }
    return users;
  }

  @override
  UserLocationRequest fromMap(Map<String, dynamic> query) {
    return UserLocationRequest(
      id: query[columnId],
      uuid: query[columnUUID],
      latitude: query[columnLatitude],
      longitude: query[columnLongitude],
      timestamp: query[columnTimestamp],
    );
  }

  @override
  Map<String, dynamic> toMap(UserLocationRequest object) {
    return <String, dynamic>{
      columnId: object.id,
      columnUUID: object.uuid,
      columnLatitude: object.latitude,
      columnLongitude: object.longitude,
      columnTimestamp: object.timestamp,
    };
  }
}
