import 'package:flutter/material.dart';
import 'package:py_quest/Models/userDataClass.dart';

class UserProvider with ChangeNotifier {
  CurrentUserData? _user;

  CurrentUserData? get getUser => _user;

  // Future<void> refreshUser() async {
  //   CurrentUserData user = await _authMethods.getUserDetails();
  //   _user = user;
  //   notifyListeners();
  // }
}
