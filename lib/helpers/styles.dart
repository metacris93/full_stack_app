import 'dart:ui';

import 'package:flutter/material.dart';

class Styles {
  static const _textSizeLarge = 25.0;
  static const _textSizeDefault = 16.0;
  static final Color _textColorStrong = _hexToColor('000000');
  static final Color _textColorDefault = _hexToColor('666666');
  static const String _fontNameDefault = 'Muli';
  static final navBarTitle = TextStyle(
    fontFamily: _fontNameDefault,
  );
  static final headerLarge = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeLarge,
    color: _textColorStrong,
  );
  static final textDefault = TextStyle(
    fontFamily: _fontNameDefault,
    fontSize: _textSizeDefault,
    color: _textColorDefault,
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }

  static AppBar getAppBar(String title) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.blue[900],
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  static TextStyle get getNavBarTitle => navBarTitle;
  static TextStyle get getHeaderLarge => headerLarge;
  static TextStyle get getTextDefault => textDefault;
}
