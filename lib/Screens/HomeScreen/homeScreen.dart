import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:news_app/GetxControllers/controllers.dart';
import 'package:news_app/GetxControllers/firebaseController.dart';
import 'package:news_app/Screens/ArticleData/articleData.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  Controller controller = Get.put(Controller());

  FirebaseController firebaseController = Get.put(FirebaseController());

  var db = FirebaseFirestore.instance.collection('articleData').snapshots();

  void addProductdataTofireBase({Map mapdata}) {
// ignore: deprecated_member_use
    CollectionReference collectionReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection('savedArticles');

    collectionReference.add(mapdata).catchError((e) {
      print(e.toString());
    });
    print("Product Information Added");
  }

  bool btnCOLOR = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
          stream: db,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return snapshot.hasData
                ? GridView.builder(
                    itemCount: snapshot.data.docs.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 20, crossAxisCount: 2),
                    itemBuilder: (BuildContext context, index) {
                      if (snapshot.data.docs[index].data()['title'] == null) {
                        return CircularProgressIndicator(
                          strokeWidth: 2,
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          
                          color: Theme.of(context).primaryColor.withOpacity(0.8),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.to(ArticleData(index: index));
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
                                      .addFavouriteArticlesTofirebase(
                                          snapshot: snapshot, index: index);
                                  Get.snackbar('Article', 'Added');
                                },
                                child: Icon(
                                  Icons.favorite_border_sharp,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                              Positioned(
                                  left: 20,
                                  height: 30,
                                  bottom: 0,
                                  child: Text(
                                    "${snapshot.data.docs[index]['title']}",
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
