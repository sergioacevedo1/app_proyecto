import 'package:flutter/material.dart';

class UIAnimalService extends ChangeNotifier {
  int _selectedAnimalOpt = 0;

  int get selectedAnimalOpt {
    return _selectedAnimalOpt;
  }

  set selectedAnimalOpt(int value) {
    _selectedAnimalOpt = value;
    notifyListeners();
  }
}
