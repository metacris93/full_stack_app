import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:full_stack_app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await customCertificateOldDevices();
  // runApp(const MyApp());
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
