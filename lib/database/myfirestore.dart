
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*
 Storing posts published by users
 Components of post:
     - message
     - email
     - timestamp
 */


class FirestoreDatabase{

  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference posts = FirebaseFirestore.instance.collection("Posts");

//   Adding posts
  Future<void> addPost(String message){
    return posts.add({
      'UserEmail' : user!.email,
      'PostedMessages' : message,
      'TimeStamp' : Timestamp.now()
    });
  }

//   Getting all posts
  Stream<QuerySnapshot> getPosts() {
    final postStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy('TimeStamp', descending: true)
        .snapshots();

    return postStream;
  }



}