import 'package:flutter/material.dart';
import 'package:google_sign_in_all/google_sign_in_all.dart';
import 'package:news_app/GetxControllers/controllers.dart';
import 'package:news_app/GetxControllers/firebaseController.dart';
import 'package:news_app/Screens/Explore/explore.dart';
import 'package:news_app/constant.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

bool isSwitched = false;

class AppSettings extends StatefulWidget {
  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  FirebaseController firebaseController = Get.put(FirebaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          Container(
            height: 400,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Theme.of(context).accentColor,
                    onTap: () {
                      Get.bottomSheet(Container(
                        height: 200,
                        decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10))),
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 32.0, left: 32.0, top: 16.0, bottom: 32.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Login",
                                  style:  Theme.of(context).textTheme.bodyText1,
                                ),
                                Card(
                                  child: ListTile(
                                    leading: Icon(FontAwesomeIcons.google),
                                    title: Text('Google'),
                                    onTap: () {
                                      firebaseController.googleLoginIn();
                                    },
                                  ),
                                ),
                              ]),
                        ),
                      ));
                    },
                    title:
                        GetBuilder<FirebaseController>(builder: (controller) {
                      return firebaseController.isLoggedIn
                          ? Text(
                              "${controller.email}",
                              style: TextStyle(color: Colors.white, fontSize: 17),
                            )
                          : Text(
                              "Login",
                              style:  Theme.of(context).textTheme.bodyText1,
                            );
                    }),
                    trailing:
                        GetBuilder<FirebaseController>(builder: (controller) {
                      return firebaseController.isLoggedIn
                          ? InkWell(
                              onTap: () {
                                firebaseController.googleSignOut();
                              },
                              child: Icon(Icons.logout,))
                          : Icon(Icons.arrow_forward_ios);
                    }),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: 10.0, left: 10.0, top: 12.0, bottom: 25.0),
                  child: ListTile(
                      trailing: Switch(
                        activeTrackColor: Colors.white,
                        activeColor: Colors.blueAccent,
                        inactiveTrackColor: Colors.white,
                        inactiveThumbColor: Colors.black,
                        value: isSwitched,
                        onChanged: (value) {
                          Get.isDarkMode
                              ? Get.changeTheme(klightTheme)
                              : Get.changeTheme(kdarkTheme);
                          setState(() {
                            isSwitched = value;
                          });
                        },
                      ),
                      tileColor: Theme.of(context).accentColor,
                      leading: Text(
                        "Dark Mode",
                        style: Theme.of(context).textTheme.bodyText1
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
