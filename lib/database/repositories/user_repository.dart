import 'package:full_stack_app/database/database.dart';
import 'package:full_stack_app/models/user_sign_in.dart';

class UserRepository {
  final DBProvider dbProvider;

  UserRepository({required this.dbProvider});

  Future<UserSignIn> insert(UserSignIn user) async {
    final db = await dbProvider.database;
    await db.insert('users', user.toMap());
    return user;
  }

  Future<UserSignIn> fetchById(int id) async {
    final db = await dbProvider.database;
    final List<Map<String, dynamic>> maps =
        await db.query('users', where: 'id = ?', whereArgs: [id]);
    final user = maps.length == 1
        ? UserSignIn(
            id: maps[0]['id'] as int,
            name: maps[0]['name'] as String,
            username: maps[0]['username'] as String,
            email: maps[0]['email'] as String,
            token: maps[0]['token'] as String,
          )
        : throw Exception('User not found');
    return user;
  }
}
