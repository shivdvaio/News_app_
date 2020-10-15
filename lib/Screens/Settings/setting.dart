import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:news_app/GetxControllers/firebaseController.dart';
import 'package:news_app/data.dart';

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
                  child: Card(
                    child: ListTile(
                      tileColor: Theme.of(context).accentColor,
                      onTap: () {
                        if (firebaseController.isLoggedIn != true) {
                          Get.bottomSheet(Container(
                            height: 200,
                            decoration: BoxDecoration(
                                color: Theme.of(context).canvasColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10))),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right: 32.0,
                                  left: 32.0,
                                  top: 16.0,
                                  bottom: 32.0),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Login",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(fontSize: 25),
                                    ),
                                    Card(
                                      child: ListTile(
                                        leading: Icon(FontAwesomeIcons.google),
                                        title: Text('Google',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(fontSize: 17)),
                                        onTap: () {
                                          firebaseController.googleLoginIn(
                                              context: context);
                                        },
                                      ),
                                    ),
                                  ]),
                            ),
                          ));
                        }
                      },
                      title:
                          GetBuilder<FirebaseController>(builder: (controller) {
                        return firebaseController.isLoggedIn
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  children: [
                                    Text(
                                      "${controller.displayName}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(fontSize: 18),
                                    ),
                                    Text(
                                      "${controller.email}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(fontSize: 18),
                                    ),
                                  ],
                                ),
                              )
                            : Text(
                                "Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(fontSize: 18),
                              );
                      }),
                      leading:
                          GetBuilder<FirebaseController>(builder: (controller) {
                        return firebaseController.isLoggedIn == true
                            ? CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                    '${controller.displaypicUrl}'))
                            : Icon(Icons.login_sharp);
                      }),
                      trailing:
                          GetBuilder<FirebaseController>(builder: (controller) {
                        return firebaseController.isLoggedIn
                            ? InkWell(
                                onTap: () {
                                  firebaseController.googleSignOut();
                                },
                                child: Icon(
                                  Icons.logout,
                                ))
                            : Icon(Icons.arrow_forward_ios);
                      }),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: 10.0, left: 10.0, top: 12.0, bottom: 25.0),
                  child: Card(
                    child: ListTile(
                        title: Text("Dark Mode",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(fontSize: 18)),
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
                        leading: Icon(Icons.nights_stay)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
