import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:news_app/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleData extends StatefulWidget {
  final index;
  ArticleData({this.index});
  @override
  _ArticleDataState createState() => _ArticleDataState();
}

class _ArticleDataState extends State<ArticleData> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: InkWell(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (BuildContext context) {
              //   return MyApp();
              // }));
              Navigator.of(context).pop();
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
                      .collection('articleData')
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
                    .collection('articleData')
                    .snapshots(),
                builder: (BuildContext context, snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return Html(
                    data: """${snapshot.data.docs[widget.index]['htmlData']}""",
                    onLinkTap: (url){
                       WebView(initialUrl: url,);
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
