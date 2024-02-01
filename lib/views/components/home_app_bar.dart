import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HomeAppBarState extends State<HomeAppBar> {
  String? _versionApp;

  @override
  void initState() {
    _loadVersionApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Home ${_versionApp ?? ''}',
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue[900],
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  void _loadVersionApp() async {
    final packageInfo = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _versionApp = 'v.${packageInfo.version}';
      });
    }
  }
}
