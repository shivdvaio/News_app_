import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

final kdarkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white, fontSize: 23),
      
      ),
    ),
    textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white),
  
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
     unselectedIconTheme:IconThemeData(color: Colors.white)
    ),
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF212121),
    accentColor: Color(0xFF212121),
    accentIconTheme: IconThemeData(color: Colors.white),
    secondaryHeaderColor: Colors.white,
    focusColor: Colors.white);

final klightTheme = ThemeData.light().copyWith(
   
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.black, fontSize: 23),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
     unselectedIconTheme:IconThemeData(color: Colors.black)
    ),
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Color(0xffeeeeee),
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black,
    secondaryHeaderColor: Colors.black,
    focusColor: Colors.black);



  List<BottomNavigationBarItem> bottomNavItemsAndroid = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        // ignore: deprecated_member_use
        title: Text('Home'),
        activeIcon: Icon(
          Icons.home,
          color: Colors.blue,
        )),
    BottomNavigationBarItem(
        icon: Icon(Icons.explore),
        // ignore: deprecated_member_use
        title: Text('Explore'),
        activeIcon: Icon(
          Icons.explore,
          color: Colors.blue,
        )),
        BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border_sharp),
        // ignore: deprecated_member_use
        title: Text('Favourites'),
        activeIcon: Icon(
         Icons.favorite_border_sharp,
          color: Colors.blue,
        )),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        // ignore: deprecated_member_use
        title: Text('Settings'),
        activeIcon: Icon(
          Icons.settings,
          color: Colors.blue,
        ))
  ];
