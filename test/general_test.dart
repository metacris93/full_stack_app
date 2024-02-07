import 'package:full_stack_app/database/database.dart';
import 'package:full_stack_app/database/repositories/user_repository.dart';
import 'package:full_stack_app/models/user_sign_in.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<Database> mockInMemoryDatabase(List<String> sqlList) async {
  final db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
  for (var sql in sqlList) {
    await db.execute(sql);
  }
  DBProvider.instance.setDatabase(db);
  return db;
}

Future<UserSignIn> insertDefaultUser(UserRepository userRepository) async {
  final user = UserSignIn(
    username: 'test_username',
    name: 'test_name',
    email: 'test_email',
    token: 'test_token',
  );
  return await userRepository.insert(user);
}
