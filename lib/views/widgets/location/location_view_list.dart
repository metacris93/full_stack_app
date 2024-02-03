import 'package:flutter/material.dart';
import 'package:full_stack_app/models/location.dart';

class LocationViewList extends StatefulWidget {
  final List<Location> locations;
  const LocationViewList({Key? key, required this.locations}) : super(key: key);

  @override
  State<LocationViewList> createState() => _LocationViewListState();
}

class _LocationViewListState extends State<LocationViewList> {
  late List<Location> locations;

  @override
  void initState() {
    super.initState();
    locations = widget.locations;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Locations',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const Center(child: Text('Location')),
    );
  }
}
