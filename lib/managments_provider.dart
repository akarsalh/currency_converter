import 'package:flutter/material.dart';

class Comp extends ChangeNotifier {
  String from = "";
  String to = "";
  String temp = "";
  List<String> currencies = [];

  double rate = 0;
  String result = "";

  void switchCurrencies() {
    temp = from;
    from = to;
    to = temp;

    notifyListeners();
  }

  void setFromVal(String val) {
    from = val;
    notifyListeners();
  }

  void setToVal(String val) {
    to = val;
    notifyListeners();
  }

  void setCurrencies(List<String> val) {
    currencies = val;
    notifyListeners();
  }

  void setRate(double val) {
    rate = val;
    notifyListeners();
  }

  void setResult(String val) {
    result = val;
  }
}
