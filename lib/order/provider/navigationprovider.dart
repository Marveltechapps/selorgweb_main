
import 'package:flutter/material.dart';

class Navigationprovider extends ChangeNotifier{
  int sectionId = 0;

  void updatesectionId(var section){
    sectionId = section;
    notifyListeners();
  }

}