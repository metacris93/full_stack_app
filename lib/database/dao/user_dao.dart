import 'package:full_stack_app/database/dao/dao.dart';
import 'package:full_stack_app/models/user_sign_in.dart';

class UserDao extends Dao<UserSignIn> {
  final tableName = 'users';
  final columnId = 'id';
  final columnUsername = 'username';
  final columnName = 'name';
  final columnEmail = 'email';
  final columnToken = 'token';

  @override
  String get createTableQuery => '''
      CREATE TABLE $tableName(
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnUsername TEXT NOT NULL,
        $columnName TEXT NOT NULL,
        $columnEmail TEXT NOT NULL,
        $columnToken TEXT NOT NULL
      )
    ''';

  @override
  List<UserSignIn> fromList(List<Map<String, dynamic>> query) {
    List<UserSignIn> users = List<UserSignIn>.empty();
    for (var map in query) {
      users.add(fromMap(map));
    }
    return users;
  }

  @override
  UserSignIn fromMap(Map<String, dynamic> query) {
    return UserSignIn(
      name: query[columnName],
      username: query[columnUsername],
      email: query[columnEmail],
      token: query[columnToken],
    );
  }

  @override
  Map<String, dynamic> toMap(UserSignIn object) {
    return <String, dynamic>{
      columnUsername: object.username,
      columnName: object.name,
      columnEmail: object.email,
      columnToken: object.token,
    };
  }
}
