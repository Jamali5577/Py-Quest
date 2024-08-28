// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller1;

  String lable;
  bool ispass;
  int? maxLines = 1;
  bool readOnly;

  CustomTextField({
    Key? key,
    required this.controller1,
    required this.lable,
    required this.ispass,
    this.maxLines,
    required this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      maxLines: maxLines,
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
      ),
    );
  }
}
