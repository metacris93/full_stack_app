import 'package:flutter/material.dart';
import 'package:full_stack_app/views/widgets/map/lite_mode.dart';
import 'package:full_stack_app/views/widgets/map/map_base.dart';
import 'package:full_stack_app/views/widgets/map/map_click.dart';
import 'package:full_stack_app/views/widgets/map/map_map_id.dart';
import 'package:full_stack_app/views/widgets/map/map_ui.dart';
import 'package:full_stack_app/views/widgets/map/move_camera.dart';
import 'package:full_stack_app/views/widgets/map/padding.dart';
import 'package:full_stack_app/views/widgets/map/place_marker.dart';
import 'package:full_stack_app/views/widgets/map/place_polygon.dart';
import 'package:full_stack_app/views/widgets/map/place_polyline.dart';
import 'package:full_stack_app/views/widgets/map/scrolling_map.dart';
import 'package:full_stack_app/views/widgets/map/snapshot.dart';
import 'package:full_stack_app/views/widgets/map/tile_overlay.dart';

final List<GoogleMapBasePage> _allMapPages = <GoogleMapBasePage>[
  const PlaceMarkerPage(),
  const LiteModePage(),
  const MapClickPage(),
  const MapIdPage(),
  const MapUiPage(),
  const SnapshotPage(),
  const TileOverlayPage(),
  const ScrollingMapPage(),
  const PaddingPage(),
  const MoveCameraPage(),
  const PlacePolygonPage(),
  const PlacePolylinePage(),
];

class MapMainPage extends StatelessWidget {
  /// Default Constructor
  const MapMainPage({super.key});

  void _pushPage(BuildContext context, GoogleMapBasePage page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => Scaffold(
          appBar: AppBar(title: Text(page.title)),
          body: page,
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GoogleMaps examples')),
      body: ListView.builder(
        itemCount: _allMapPages.length,
        itemBuilder: (_, int index) => ListTile(
          leading: _allMapPages[index].leading,
          title: Text(_allMapPages[index].title),
          onTap: () => _pushPage(context, _allMapPages[index]),
        ),
      ),
    );
  }
}