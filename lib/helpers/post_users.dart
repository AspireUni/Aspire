import 'package:cloud_firestore/cloud_firestore.dart';

Future postUsers(allUsers) async {
  for (var user in allUsers) {
    Firestore
      .instance
      .collection("users")
      .document(user["id"])
      .setData(user);
  }
}