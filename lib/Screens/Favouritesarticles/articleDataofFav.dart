import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'package:url_launcher/url_launcher.dart';

class ArticleDataofFav extends StatefulWidget {
  final index;
  ArticleDataofFav({this.index});
  @override
  _ArticleDataofFavState createState() => _ArticleDataofFavState();
}

class _ArticleDataofFavState extends State<ArticleDataofFav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
          ),
          backgroundColor: Colors.transparent),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('savedArticles')
                      .snapshots(),
                  builder: (BuildContext context, snapshot) {
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    }
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl:
                            "${snapshot.data.docs[widget.index].data()['imageAddress']}",
                        fit: BoxFit.fill,
                        placeholder: (context, url) =>
                            CircularProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    );
                  }),
              decoration: BoxDecoration(),
              height: 500,
            ),
            SizedBox(
              height: 20,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('savedArticles')
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return Html(
                    data: """${snapshot.data.docs[widget.index]['htmlData']}""",
                    onLinkTap: (url) {
                      
                      launch(url, forceWebView: true);
                    },
                  );
                })
          ],
        ),
      ),
    ));
  }
}