import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:news_app/Services/searchServices.dart';

class Controller extends GetxController {
  List<int> favouriteItemIndexList = [];

  bool favouriteIconcolor = false;

  int favouriteItemIndex;
  int selectedIndex = 0;

  String appTitle = "Home";
  int indexValue = 0;
  void changeTitle({int index}) {
    indexValue = index;
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

  

 
}
