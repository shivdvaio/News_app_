import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
            body: StreamBuilder(
                stream: db,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  return snapshot.hasData
                      ? CustomScrollView(
                          slivers: [
                            SliverGrid(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 20, crossAxisCount: 2),
                              delegate: SliverChildBuilderDelegate(
                                  (BuildContext context, index) {
                                if (snapshot.data.docs[index].data()['title'] ==
                                    null) {
                                  return CircularProgressIndicator(
                                    strokeWidth: 2,
                                  );
                                }

                                return Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 6),
                                      child: Container(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "${snapshot.data.docs[index].data()['imageAddress']}",
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.favorite_border_sharp,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    Positioned(
                                        left: 20,
                                        height: 40,
                                        bottom: 0,
                                        child: Text(
                                          "${snapshot.data.docs[index]['title']}",
                                          style: TextStyle(fontSize: 20),
                                        )),
                                  ],
                                );
                              }, childCount: snapshot.data.docs.length),
                            )
                          ],
                        )
                      : Center(child: CircularProgressIndicator());
                })),
      ),
    );
  }
}
