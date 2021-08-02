import 'package:flutter/widgets.dart';

class ApSelectionController extends ChangeNotifier {
  static ApSelectionController instance = ApSelectionController();
  String selectedIP = '0.0.0.0';
  changeIP(String ip) {
    selectedIP = ip;
    notifyListeners();
  }
}
