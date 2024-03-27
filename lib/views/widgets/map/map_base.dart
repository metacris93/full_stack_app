import 'package:flutter/material.dart';

abstract class GoogleMapBasePage extends StatelessWidget {
  const GoogleMapBasePage(this.leading, this.title, {super.key});

  final Widget leading;
  final String title;
}