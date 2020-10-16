import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:google_sign_in/google_sign_in.dart';

class FirebaseController extends GetxController {
  addFavouriteArticlesTofirebase(
      {int index, AsyncSnapshot<QuerySnapshot> snapshot}) {
    Map<String, dynamic> mapdata = {
      "title": snapshot.data.docs[index].data()['title'],
      "htmlData": snapshot.data.docs[index]['htmlData'],
      "imageAddress": snapshot.data.docs[index].data()['imageAddress']
    };

    CollectionReference collectionReference =
        // ignore: deprecated_member_use
        Firestore.instance.collection('savedArticles');

    collectionReference.add(mapdata).catchError((e) {
      print(e.toString());
    });
    print("Information Added");
  }

  deleteFavouriteArticlesFromfirebase(
      {int index, AsyncSnapshot<QuerySnapshot> snapshot}) async {
    await FirebaseFirestore.instance
        .runTransaction((Transaction myTransaction) async {
      myTransaction.delete(snapshot
          .data
          // ignore: deprecated_member_use
          .documents[index]
          .reference);
    });
  }

  String email = "Login";
  String displaypicUrl;
  String displayName;
  bool isLoggedIn = false;

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);



  googleLoginIn({BuildContext context}) async {
    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      FirebaseAuth.instance.signInWithCredential(credential);

      if (googleSignIn.currentUser != null) {
        isLoggedIn = true;
        update();
        email = googleSignIn.currentUser.email;
        update();
        displaypicUrl = googleSignIn.currentUser.photoUrl;

        update();
        displayName = googleSignIn.currentUser.displayName;
        update();

        Get.bottomSheet(Container(
            height: 200,
            decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.solidCheckCircle,
                  size: 35,
                ),
                Text(
                  'Logged In Successfully',
                  style: TextStyle(fontSize: 20),
                )
              ],
            )));
      }
    } catch (error) {
      print(error);
    }
  }

  googleSignOut() async {
    try {
      await googleSignIn.signOut();
      isLoggedIn = false;
      update();
    } catch (error) {
      print(error);
    }
  }
}
