import 'package:flutter/material.dart';

void redirectToRoute(bool doPop, Route<dynamic> route, BuildContext context) {
  if (doPop) Navigator.pop(context);
  Navigator.push(context, route);
}

Future<void> replacementToRouteNamed(
    bool doPop, String routeName, BuildContext context) async {
  if (doPop) Navigator.pop(context);
  await Navigator.pushReplacementNamed(context, routeName);
}
