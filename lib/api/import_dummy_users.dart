import 'package:cloud_firestore/cloud_firestore.dart';
import "./dummy_users.dart";

// Testing firestore operations
Future importDummyData() async {
  // Upload multiple dummy users at one time to firestore
  for (var user in dummyUsers) {
    print(user);
    Firestore
      .instance
      .collection("users")
      .document(user["id"])
      .setData({
        "name": user["id"], 
        "type": user["type"]
      });
  }

  // Upload dummy document to firestore
  // Firestore.instance.collection('books').document()
  // .setData({ 'title': 'title', 'author': 'author' });

  // Read the firestore
  // Firestore.instance
  //       .collection('users')
  //       .getDocuments()
  //       .then((QuerySnapshot snapshot) {
  //         snapshot.documents.forEach((f) => print('${f.data}}'));
  //       });
  print("Done");
}