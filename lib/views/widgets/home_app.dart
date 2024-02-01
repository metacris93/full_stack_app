import 'package:flutter/material.dart';
import 'package:full_stack_app/views/components/drawer_menu.dart';
import 'package:full_stack_app/views/components/home_app_bar.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: HomeAppBar(),
      drawer: DrawerMenu(),
      body: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Center(
              child: Text('Home'),
            ),
          ),
        ],
      ),
    );
  }
}
