import 'package:flutter/material.dart';
// import 'package:full_stack_app/helpers/styles.dart';
import 'package:full_stack_app/models/location.dart';
import 'package:full_stack_app/views/widgets/location/location_detail.dart';

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
        body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: _listViewItemBuilder,
        ));
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var location = locations[index];
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      leading: _itemThumbnail(location),
      title: _itemTitle(location),
      onTap: () => _navigationToLocationDetail(context, location),
    );
  }

  void _navigationToLocationDetail(BuildContext context, Location location) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LocationDetail(location: location)));
  }

  Widget _itemThumbnail(Location location) {
    return Container(
      constraints: const BoxConstraints.tightFor(width: 100.0),
      child: Image.network(
        location.url,
        fit: BoxFit.fitHeight,
      ),
    );
  }

  Widget _itemTitle(Location location) {
    return Text(
      location.name,
      // style: Styles.getTextDefault,
    );
  }
}
