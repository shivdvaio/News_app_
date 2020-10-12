import 'package:bottom_navy_bar/bottom_navy_bar.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/GetxControllers/controllers.dart';
import 'package:news_app/Screens/Explore/explore.dart';
import 'package:news_app/Screens/Favouritesarticles/favouritesArticles.dart';
import 'package:news_app/Screens/HomeScreen/homeScreen.dart';

import 'package:get/get.dart';

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

var selectedIndex = 0;

class _MyAppState extends State<MyApp> {
  PageController _pageController = PageController();
  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
              bottomNavigationBar: BottomNavyBar(
                showElevation: false,
                selectedIndex: selectedIndex,
                onItemSelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                  _pageController.animateToPage(index,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInQuad);
                },
                items: <BottomNavyBarItem>[
                  BottomNavyBarItem(
                      inactiveColor: Colors.white,
                      activeColor: Colors.blue,
                      title: Text("Home"),
                      icon: Icon(Icons.home)),
                  BottomNavyBarItem(
                      inactiveColor: Colors.white,
                      activeColor: Colors.blue,
                      title: Text('Explore'),
                      icon: Icon(
                        Icons.search,
                        size: 25,
                      )),
                  BottomNavyBarItem(
                      inactiveColor: Colors.white,
                      activeColor: Colors.blue,
                      title: Text('Saved'),
                      icon: Icon(Icons.save_rounded)),
                  BottomNavyBarItem(
                      inactiveColor: Colors.white,
                      activeColor: Colors.blue,
                      title: Text('Settings'),
                      icon: Icon(Icons.settings_outlined)),
                ],
              ),
              appBar: AppBar(
                elevation: 0,
                  title: GetBuilder<Controller>(
                      init: Controller(),
                      builder: (controller) {
                        return Text("${controller.appTitle}");
                      })),
              body: PageView(
                onPageChanged: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                  controller.changeTitle(index: index);
                },
                controller: _pageController,
                children: [
                  HomeScreen(),
                  Explore(),
                  FavouriteArticles(),
                  AppSettings()
                ],
              ))),
    );
  }
}
