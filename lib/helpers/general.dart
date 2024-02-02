import 'package:flutter/material.dart';

void redirectToRoute(bool doPop, Route<dynamic> route, BuildContext context) {
  if (doPop) Navigator.pop(context);
  Navigator.push(context, route);
}
