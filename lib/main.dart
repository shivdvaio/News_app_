import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/Database/databasehelper.dart';
import 'package:news_app/GetxControllers/controllers.dart';
import 'package:news_app/Screens/Explore/explore.dart';
import 'package:news_app/Screens/Favouritesarticles/favouritesArticles.dart';
import 'package:news_app/Screens/HomeScreen/homeScreen.dart';
import 'package:get/get.dart';
import 'package:news_app/Screens/Settings/setting.dart';

import 'package:news_app/data.dart';

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
      theme: klightTheme,
      debugShowCheckedModeBanner: false,
      home: SafeArea(
          child: Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                
                currentIndex: selectedIndex,
                items: bottomNavItemsAndroid,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
            _pageController.animateToPage(index,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutQuad);
                    
                },
              ),
              appBar: AppBar(
                  centerTitle: true,
                  title: GetBuilder<Controller>(
                      init: Controller(),
                      builder: (controller) {
                        return Text(
                          "${controller.appTitle}",
                        );
                      })),
              body: PageView(
                onPageChanged: (index) async {
                  setState(() {
                    selectedIndex = index;
                  });
                 List<Map<String,dynamic>> data =  await DatabaseHelper.instance.queryAll();
                 print(data);
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
// BottomNavyBar(
//                 showElevation: false,
//                 selectedIndex: selectedIndex,
//                 onItemSelected: (index) {
//                   setState(() {
//                     selectedIndex = index;
//                   });
//                   _pageController.animateToPage(index,
//                       duration: Duration(milliseconds: 300),
//                       curve: Curves.easeInQuad);
//                 },
//                 items: <BottomNavyBarItem>[
//                   BottomNavyBarItem(
//                       inactiveColor: Theme.of(context).accentColor,
//                       activeColor: Colors.blue,
//                       title: Text("Home",
//                           style:
//                               TextStyle(color: Theme.of(context).accentColor)),
//                       icon: Icon(Icons.home)),
//                   BottomNavyBarItem(
//                       inactiveColor: Theme.of(context).accentColor,
//                       activeColor: Colors.blue,
//                       title: Text('Explore'),
//                       icon: Icon(
//                         Icons.search,
//                         size: 25,
//                         color: Theme.of(context).primaryColor,
//                       )),
//                   BottomNavyBarItem(
//                       inactiveColor: Theme.of(context).accentColor,
//                       activeColor: Colors.blue,
//                       title: Text('Favourites'),
//                       icon: Icon(
//                         Icons.save_rounded,
//                         color: Theme.of(context).primaryColor,
//                       )),
//                   BottomNavyBarItem(
//                       inactiveColor: Theme.of(context).accentColor,
//                       activeColor: Colors.blue,
//                       title: Text('Settings'),
//                       icon: Icon(
//                         Icons.settings_outlined,
//                         color: Theme.of(context).accentColor,
//                       )),
//                 ],
//               )
