import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'AI COVID Scan';

  static const List<String> scanResults = [
    'Covid',
    'Normal',
    'Viral Pneumonia',
  ];

  static const Map<String, Color> resultColors = {
    'Covid': Colors.red,
    'Normal': Colors.green,
    'Viral Pneumonia': Colors.orange,
  };
}
