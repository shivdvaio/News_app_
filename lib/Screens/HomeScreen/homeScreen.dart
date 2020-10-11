import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:news_app/GetxControllers/controllers.dart';
import 'package:news_app/Screens/ArticleData/articleData.dart';

class HomeScreen extends StatelessWidget {
  Controller controller = Get.put(Controller());

  HomeScreen({
    Key key,
    @required this.db,
  }) : super(key: key);

  final Stream<QuerySnapshot> db;
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

                      return Stack(
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
                              
                            },
                            child: Icon(
                              Icons.favorite,
                              color:Colors.white,
                                  
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
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}
