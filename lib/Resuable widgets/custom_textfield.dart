// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  TextEditingController controller1;
  IconData icon;
  String lable;
  bool ispass;

  MyWidget({
    Key? key,
    required this.controller1,
    required this.icon,
    required this.lable,
    required this.ispass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(fontSize: 18, color: Colors.white),
      obscureText: ispass,
      controller: controller1,
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 18),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        label: Text(
          lable,
          style: TextStyle(color: Colors.white),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}
