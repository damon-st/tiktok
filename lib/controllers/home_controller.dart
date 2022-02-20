import 'package:get/get.dart';

class HomeController extends GetxController {
  int index = 0;

  void selectedIndex(int index) {
    this.index = index;
    update(["home"]);
  }

  Future<bool> onWillPop() async {
    if (index != 0) {
      selectedIndex(0);
      return false;
    } else {
      return true;
    }
  }
}
