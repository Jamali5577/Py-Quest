// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomIconbtn extends StatelessWidget {
  VoidCallback ontap;
  Icon icon;
  Color color;

  CustomIconbtn({
    Key? key,
    required this.ontap,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: ontap,
      icon: icon,
      color: color,
    );
  }
}
