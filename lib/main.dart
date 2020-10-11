import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/GetxControllers/controllers.dart';
import 'package:news_app/Screens/Explore/explore.dart';
import 'package:news_app/Screens/HomeScreen/homeScreen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import 'package:news_app/Screens/Saved/saved.dart';
import 'package:news_app/Screens/Settings/setting.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var db = FirebaseFirestore.instance.collection('articleData').snapshots();

  PageController _pageController = PageController();
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            bottomNavigationBar: CustomBottomNavigationBar(
              backgroundColor: Colors.black12,
              onTap: (index) {
                _pageController.animateToPage(index,
                    curve: Curves.easeInOutCubic,
                    duration: Duration(milliseconds: 600));
              },
              items: [
                CustomBottomNavigationBarItem(
                  icon: Icons.home_filled,
                  title: "Home",
                ),
                CustomBottomNavigationBarItem(
                  icon: Icons.search,
                  title: "Explore",
                ),
                CustomBottomNavigationBarItem(
                  icon: Icons.save_rounded,
                  title: "Saved",
                ),
                CustomBottomNavigationBarItem(
                  icon: Icons.settings,
                  title: "Settings",
                ),
              ],
            ),
            appBar: AppBar(
                title: GetBuilder<Controller>(
                    init: Controller(),
                    builder: (controller) {
                      return Text("${controller.appTitle}");
                    })),
            body: PageView(
              onPageChanged: (index) {
                controller.changeTitle(index: index);
              },
              controller: _pageController,
              children: [
                HomeScreen(db: db),
                Explore(),
                SavedArticles(),
                AppSettings()
              ],
            )),
      ),
    );
  }
}
