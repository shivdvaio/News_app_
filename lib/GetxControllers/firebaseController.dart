import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
  
  bool isLoggedIn = false;

  GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  googleLoginIn() async {
    try {
      await googleSignIn.signIn();
      isLoggedIn = true;
      email = googleSignIn.currentUser.email;
      update();


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
