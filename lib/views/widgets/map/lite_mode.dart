// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:full_stack_app/views/widgets/map/map_base.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

const CameraPosition _kInitialPosition =
    CameraPosition(target: LatLng(-33.852, 151.211), zoom: 11.0);

class LiteModePage extends GoogleMapBasePage {
  const LiteModePage({Key? key})
      : super(const Icon(Icons.map), 'Lite mode', key: key);

  @override
  Widget build(BuildContext context) {
    return const _LiteModeBody();
  }
}

class _LiteModeBody extends StatelessWidget {
  const _LiteModeBody();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.0),
        child: Center(
          child: SizedBox(
            width: 300.0,
            height: 300.0,
            child: GoogleMap(
              initialCameraPosition: _kInitialPosition,
              liteModeEnabled: true,
            ),
          ),
        ),
      ),
    );
  }
}
