import 'package:flutter/material.dart';

class TenantListProvider extends ChangeNotifier {
  List _tenantList = [];

  List get tenantList => _tenantList;

  void updateTenantList(List tenants) {
    _tenantList = tenants;
    notifyListeners();
  }
}
