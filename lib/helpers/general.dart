import 'package:flutter/material.dart';
import 'package:full_stack_app/models/user_sign_in.dart';
import 'package:geolocator/geolocator.dart';

const notificationChannelId = 'full_stack_service_app';
const notificationId = 555;
const notificationTitle = 'Sincronización';

String get getNotificationChannelId => notificationChannelId;
String get getNotificationTitle => notificationTitle;
int get getNotificationId => notificationId;

void redirectToRoute(bool doPop, Route<dynamic> route, BuildContext context) {
  if (doPop) Navigator.pop(context);
  Navigator.push(context, route);
}

Future<void> replacementToRouteNamed(
    bool doPop, String routeName, BuildContext context) async {
  if (doPop) Navigator.pop(context);
  await Navigator.pushReplacementNamed(context, routeName);
}

Future<Position> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Los servicios de ubicación están desactivados.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Los permisos de ubicación están denegados');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        'Los permisos de ubicación están permanentemente denegados, no podemos solicitar permisos.');
  }

  return await Geolocator.getCurrentPosition();
}

Map<String, String> getAuthenticationHeader(UserSignIn user) {
  return <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${user.token}'
  };
}
