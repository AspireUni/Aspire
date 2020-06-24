import 'package:cloud_firestore/cloud_firestore.dart';
import "./dummy_data.dart";

Future importDummyData() async {
  for (var user in dummyUsers) {
    Firestore
      .instance
      .collection("users")
      .document(user["id"])
      .setData({
        "name": user["id"], 
        "type": user["type"]
      });
  }
}