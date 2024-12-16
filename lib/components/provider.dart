import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? username;
  String? email;
  String? firstName;
  String? lastName;

  void setUser(Map<String, dynamic> userData) {
    username = userData['username'];
    email = userData['email'];
    firstName = userData['first_name'];
    lastName = userData['last_name'];
    notifyListeners();
  }

  void clearUser() {
    username = null;
    email = null;
    firstName = null;
    lastName = null;
    notifyListeners();
  }
}
