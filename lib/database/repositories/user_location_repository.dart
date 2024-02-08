import 'package:full_stack_app/database/database.dart';
import 'package:full_stack_app/models/user_location_request.dart';

class UserLocationRepository {
  final DBProvider dbProvider;

  UserLocationRepository({required this.dbProvider});

  Future<UserLocationRequest> insert(UserLocationRequest user) async {
    final db = await dbProvider.database;
    await db.insert('user_location', user.toMap());
    return user;
  }

  Future<List<UserLocationRequest>> getAll() async {
    final db = await dbProvider.database;
    List<Map<String, dynamic>> users =
        await db.rawQuery('SELECT * FROM user_location');
    List<UserLocationRequest> data = [];
    for (var user in users) {
      data.add(UserLocationRequest.fromStorage(user));
    }
    return data;
  }
}
