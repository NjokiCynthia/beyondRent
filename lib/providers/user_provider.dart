import 'package:flutter/material.dart';

class User {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String id;
  final String token;

  User({
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.id,
    required this.token,
  });
}

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User user) {
    _user = user;

    notifyListeners();
  }
}
