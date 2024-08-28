import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDetails extends ChangeNotifier {
  String? userId;
  String? userName;
  String? email;
  String? password;
  String? picUrl;
  double? points;

  void setUsersDetails(DataSnapshot snapshot) {
    if (snapshot.value != "" && snapshot.value != null) {
      userId = snapshot.child('userId').value.toString();
      userName = snapshot.child('name').value.toString();
      email = snapshot.child('email').value.toString();
      password = snapshot.child('password').value.toString();
      points = double.parse(snapshot.child('point').value.toString());
      notifyListeners();
      //here we store the preferences of bthe user
      setUserPreferences();
      // getUsersDetailsFromPref();
    }
  }

  void getUsersDetailsFromPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('id');
    userName = prefs.getString('name');
    email = prefs.getString('email');
    points = prefs.getDouble('point');
    // userName = snapshot.child('name').value.toString();
    // email = snapshot.child('email').value.toString();
    // password = snapshot.child('password').value.toString();

    //   notifyListeners();
    //   //here we store the preferences of bthe user
    //   setUserPreferences();
    notifyListeners();
  }

  void setUserPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email!);
    prefs.setString('id', userId!);
    prefs.setString('name', userName!);
    if (points != null) {
      prefs.setDouble('point', double.parse(points.toString()));
    }
    notifyListeners();
  }
}
