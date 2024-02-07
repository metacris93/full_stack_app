import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:full_stack_app/database/database.dart';
import 'package:full_stack_app/database/repositories/user_repository.dart';
import 'package:full_stack_app/http/services/location_api_service.dart';
import 'package:http/http.dart' as http;
// import 'package:sqflite/sqlite_api.dart';

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final databaseProvider = Provider<DBProvider>((ref) => DBProvider.instance);
// final databaseFutureProvider = FutureProvider<Database>((ref) async {
//   final dbProvider = ref.watch(databaseProvider);
//   return await dbProvider.database;
// });
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final dbProvider = ref.watch(databaseProvider);
  return UserRepository(dbProvider: dbProvider);
});
final locationApiServiceProvider = Provider<LocationApiService>((ref) {
  return LocationApiService(
      httpClient: ref.watch(httpClientProvider),
      userRepository: ref.watch(userRepositoryProvider));
});
