// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../Utils/device_info.dart';



class CustomButton extends StatelessWidget {
  String text;
  VoidCallback ontap;
  CustomButton({
    Key? key,
    required this.text,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(160, 17, 215, 70),
            borderRadius: BorderRadius.circular(10)),
        height: 50,
        width: screenWidth / 2,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
