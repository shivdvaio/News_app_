import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:news_app/GetxControllers/controllers.dart';
import 'package:news_app/GetxControllers/firebaseController.dart';

import 'package:get/get.dart';
import 'package:news_app/Screens/Favouritesarticles/articleDataofFav.dart';


class FavouriteArticles extends StatefulWidget {
  @override
  _FavouriteArticlesState createState() => _FavouriteArticlesState();
}

class _FavouriteArticlesState extends State<FavouriteArticles> {
  var db = FirebaseFirestore.instance.collection('savedArticles').snapshots();
  FirebaseController firebaseController = Get.put(FirebaseController());

  Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: db,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 20, crossAxisCount: 2),
                itemBuilder: (BuildContext context, index) {
                  if (snapshot.data.docs[index].data()['title'] == null) {
                    return CircularProgressIndicator(
                      strokeWidth: 2,
                    );
                  }

                  return Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ArticleDataofFav(index: index));
                          },
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
                      ),
                      InkWell(
                        onDoubleTap: () {
                          firebaseController
                              .deleteFavouriteArticlesFromfirebase(
                                  snapshot: snapshot, index: index);
                          Get.snackbar('Article', 'Deleted');
                        },
                        child: Icon(
                          Icons.delete_sharp,
                          color: Colors.white,
                          size: 30,
                        ),
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
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
