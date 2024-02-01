import 'dart:async';

import 'package:flutter/material.dart';
import 'package:full_stack_app/helpers/snackbar_global.dart';

void showError(String message,
    [int? duration = 5, String? actionText = 'OK', Function? action]) {
  Timer.run(() => _showAlert(message, Colors.red, Colors.white,
      Icons.cancel_outlined, duration!, actionText!, action));
}

void _showAlert(String message, Color bgColor, Color textColor, IconData icon,
    int duration, String actionText,
    [Function? action]) {
  final SnackBar snackBar = SnackBar(
    content: Row(
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 0, right: 8.0, top: 0, bottom: 0),
          child: Icon(
            icon,
            color: textColor,
          ),
        ),
        Flexible(
          child: Text(
            message,
            style: TextStyle(decoration: TextDecoration.none, color: textColor),
          ),
        ),
      ],
    ),
    backgroundColor: bgColor,
    duration: Duration(seconds: duration),
    action: SnackBarAction(
      label: actionText,
      textColor: textColor,
      onPressed: () {
        if (action != null) {
          action();
        }
      },
    ),
  );

  snackbarKey.currentState?.showSnackBar(snackBar);
}
