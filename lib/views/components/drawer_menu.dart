import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:full_stack_app/helpers/provider_global.dart';
import 'package:full_stack_app/models/user_sign_in.dart';
import 'package:full_stack_app/views/components/drawer_menu_model_view.dart';

final appNameProvider = FutureProvider<UserSignIn?>((ref) async {
  final dbProvider = ref.watch(databaseProvider);
  final db = await dbProvider.database;
  List<Map<String, dynamic>> users = await db.rawQuery('SELECT * FROM users');
  if (users.isNotEmpty) {
    return UserSignIn.fromStorage(users.first);
  }
  return null;
});

class DrawerMenu extends ConsumerWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appNameAsyncValue = ref.watch(appNameProvider);
    final userRepository = ref.read(userRepositoryProvider);
    final httpProvider = ref.watch(httpClientProvider);
    return Drawer(
      surfaceTintColor: Theme.of(context).primaryColor,
      backgroundColor: Theme.of(context).primaryColor,
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          getDrawerHeader(appNameAsyncValue),
          getDogSelectMenu(context),
          getLocationSelectMenu(context, httpProvider),
          getMapSelectMenu(context),
          getLogoutSelectMenu(context, userRepository),
        ],
      ),
    );
  }
}
