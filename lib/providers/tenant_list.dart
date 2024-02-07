import 'package:flutter/material.dart';

class TenantListModel extends ChangeNotifier {
  List _cachedTenants = [];

  List get cachedTenants => _cachedTenants;

  void updateCachedTenants(List tenants) {
    _cachedTenants = tenants;
    notifyListeners();
  }
}
