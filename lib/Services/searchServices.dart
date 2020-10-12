import 'package:cloud_firestore/cloud_firestore.dart';

class SearchServices{

  searchByname(String searchField){
    return FirebaseFirestore.instance.collection('articleData').where('title').get();

   

  }


}