import 'package:flutter/widgets.dart';

class ApTableController extends ChangeNotifier {
  static ApTableController instance = ApTableController();
  List<Map> apsList = [
    {'mac': '', 'model': '', 'ip': ''}
  ];
  bool searching = false;
  searchingAp() {
    searching = !searching;
    notifyListeners();
  }

  addAp(Map ap) {
    if (apsList.first['mac'].toString().compareTo('') == 0 ||
        apsList.first['mac'].toString().compareTo('') == 0 ||
        apsList.first['mac'].toString().compareTo('') == 0) {
      apsList.clear();
    }
    apsList.add(ap);
    notifyListeners();
  }

  clear() {
    apsList.clear();
    apsList.add({'mac': '', 'model': '', 'ip': ''});
    notifyListeners();
  }

  list() {
    return apsList;
  }
}
