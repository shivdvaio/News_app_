import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:news_app/GetxControllers/controllers.dart';
import 'package:news_app/GetxControllers/firebaseController.dart';
import 'package:news_app/Screens/ArticleData/articleData.dart';
import 'package:get/get.dart';


class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}
Controller controller = Get.put(Controller());
class _ExploreState extends State<Explore> {
  var db = FirebaseFirestore.instance.collection('articleData').snapshots();
    FirebaseController firebaseController = Get.put(FirebaseController());

  var dq = FirebaseFirestore.instance.settings.persistenceEnabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      
      body: Container(
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
                                 firebaseController.addFavouriteArticlesTofirebase(
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
                                height: 40,
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
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

class CustomAppBar extends PreferredSize {
  final double height;

  CustomAppBar({this.height = kToolbarHeight});

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: preferredSize.height,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: TextField(
              onChanged: (value) {
             

              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.location_city),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                hintText: "Enter City Here",
                border: OutlineInputBorder(borderSide: BorderSide.none),
              )),
        ));
  }
}
