import 'package:flutter/material.dart';
import 'package:full_stack_app/helpers/styles.dart';
import 'package:full_stack_app/models/location.dart';

class LocationDetail extends StatelessWidget {
  final Location location;
  const LocationDetail({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Styles.getAppBar(location.name),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _renderBody(context, location),
        ));
  }

  List<Widget> _renderBody(BuildContext context, Location location) {
    var result = <Widget>[];
    result.add(_bannerImage(location.url, 170.0));
    result.addAll(_renderFacts(context, location));
    return result;
  }

  List<Widget> _renderFacts(BuildContext context, Location location) {
    var result = <Widget>[];
    result.add(_sectionTitle(location.userItinerarySummary));
    result.add(_sectionText(location.tourPackageName));
    return result;
  }

  Widget _sectionTitle(String text) {
    return Container(
        padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
        child:
            Text(text, textAlign: TextAlign.left, style: Styles.headerLarge));
  }

  Widget _sectionText(String text) {
    return Container(
        padding: const EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
        child: Text(text, style: Styles.textDefault));
  }

  Widget _bannerImage(String url, double height) {
    return Container(
      constraints: BoxConstraints.tightFor(height: height),
      child: Image.network(url, fit: BoxFit.fitWidth),
    );
  }
}
