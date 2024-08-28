import 'package:flutter/material.dart';

class UiHelper {
  static CustomAlertBox(BuildContext context, String text) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(text),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 28, 44, 72),
                          borderRadius: BorderRadius.circular(50)),
                      child: Center(
                        child: Text(
                          'OK',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                        ),
                      )))
            ],
          );
        });
  }
}
