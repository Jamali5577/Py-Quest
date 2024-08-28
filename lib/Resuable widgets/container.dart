import 'package:flutter/material.dart';

import '../Utils/device_info.dart';

class ContainerCustom extends StatelessWidget {
  String textData;
  String imageUrl;
  final VoidCallback onPressed;
  ContainerCustom({
    Key? key,
    required this.textData,
    required this.imageUrl,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageUrl,
              height: screenHeight / 7,
              width: screenWidth / 4,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              textData,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            // Icon(IconData(icons))
          ],
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(screenWidth / 10)),
        height: screenHeight / 4.5,
        width: screenWidth / 2.5,
      ),
    );
  }
}
