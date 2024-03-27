import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:full_stack_app/app.dart';
import 'package:full_stack_app/services/main.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

bool isFlutterLocalNotificationsInitialized = false;
const notificationId = 15603;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'full_stack_service_app', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high, // importance must be at low or higher level
  playSound: false,
  enableVibration: false,
);
/*
REVISAR ESTE FORO PORQUE CUANDO SE CORRE EL PROYECTO SALE CON ERRORES AL INICIO.
EL MAPA SI RENDERIZA
https://issuetracker.google.com/issues/282544783
*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  await customCertificateOldDevices();

  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
    initializeMapRenderer();
  }

  runApp(const ProviderScope(child: MyApp()));
}

Completer<AndroidMapRenderer?>? _initializedRendererCompleter;
/// Initializes map renderer to the `latest` renderer type for Android platform.
///
/// The renderer must be requested before creating GoogleMap instances,
/// as the renderer can be initialized only once per application context.
Future<AndroidMapRenderer?> initializeMapRenderer() async {
  if (_initializedRendererCompleter != null) {
    return _initializedRendererCompleter!.future;
  }

  final Completer<AndroidMapRenderer?> completer =
      Completer<AndroidMapRenderer?>();
  _initializedRendererCompleter = completer;

  final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    // mapsImplementation.initializeWithRenderer(AndroidMapRenderer.latest);

    unawaited(mapsImplementation
        .initializeWithRenderer(AndroidMapRenderer.latest)
        .then((AndroidMapRenderer initializedRenderer) =>
            completer.complete(initializedRenderer)));
  } else {
    completer.complete(null);
  }

  return completer.future;
}

Future<void> customCertificateOldDevices() async {
  if (Platform.isAndroid) {
    var androidDeviceInfo = await DeviceInfoPlugin().androidInfo;
    if (androidDeviceInfo.version.sdkInt < 25) {
      // 25: Android SDK 7.1
      ByteData data =
          await PlatformAssetBundle().load('assets/ca/lets-encrypt-r3.pem');
      SecurityContext.defaultContext
          .setTrustedCertificatesBytes(data.buffer.asUint8List());
    }
  }
}
