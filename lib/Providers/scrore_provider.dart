import 'package:flutter/material.dart';

class ScroreProvider extends ChangeNotifier {
  int _score = 0;
  int get score => _score;

  addPoints() {
    _score += 5;
    //return _score;

    //notifyListeners();
    print("Score" + _score.toString());
  }
}
