import 'package:flutter/material.dart';

class FontProvider extends ChangeNotifier {
  double _fontSize = 16.0;
  String _chosenValue = 'Medium';

  final Map<String, double> fontMap = {
    'Small': 14.0,
    'Medium': 16.0,
    'Large': 18.0,
    'Extra Large': 20.0,
  };

  double get fontSize => _fontSize;
  String get chosenValue => _chosenValue;
  Map<String, double> get fontOptions => fontMap;

  void setFontSize(String sizeKey) {
    _chosenValue = sizeKey;
    _fontSize = fontMap[sizeKey] ?? 16.0;
    notifyListeners();
  }
}
