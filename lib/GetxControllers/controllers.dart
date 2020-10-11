import 'package:get/get_state_manager/get_state_manager.dart';

class Controller extends GetxController {
  bool favouriteIconcolor = false;

  String appTitle = "Home";

  void changeTitle({int index}) {
    if (index == 0) {
      appTitle = "Home";
      update();
    } else if (index == 1) {
      appTitle = "Explore";
      update();
    } else if (index == 2) {
      appTitle = "Saved";
      update();
    } else if (index == 3) {
      appTitle = "Settings";
      update();
    }
  }

  void changeColor() {
    if (favouriteIconcolor == true){
      favouriteIconcolor = false;
      update();
    } else {
      favouriteIconcolor = true;
      update();
    }
    
  }
}
