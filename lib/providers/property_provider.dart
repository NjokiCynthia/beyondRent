import 'package:flutter/material.dart';

class Property {
  final String propertyName;
  final String propertyLocation;
  final num id;

  Property({
    required this.propertyName,
    required this.propertyLocation,
    required this.id,
  });
}

class PropertyProvider extends ChangeNotifier {
  Property? _property;

  Property? get property => _property;

  void setProperty(Property property) {
    _property = property;

    notifyListeners();
  }
}
