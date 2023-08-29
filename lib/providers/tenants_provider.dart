import 'package:flutter/material.dart';

class TenantsProvider extends ChangeNotifier {
  Map<String, dynamic> _groupData = {};

  Map<String, dynamic> get groupData => _groupData;

  void setGroupData(Map<String, dynamic> groupData) {
    _groupData = groupData;
    notifyListeners();
  }
}
