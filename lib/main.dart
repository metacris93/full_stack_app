import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:full_stack_app/app.dart';
import 'package:full_stack_app/services/main.dart';

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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  await customCertificateOldDevices();
  runApp(const ProviderScope(child: MyApp()));
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
