import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants/common_constants.dart';
import '../models/models.dart';

Future<Map<String, dynamic>> getUser(String id) async {
  return (await Firestore
    .instance
    .collection("users")
    .document(id)
    .get()).data;
}

Future<QuerySnapshot> getUsers() async {
  return Firestore
    .instance
    .collection("users")
    .getDocuments();
}

Future<void> addUser(String id, String email, UserType type) async {
  var user = User.initial().copyWith(
    id: id,
    type: type,
    contact: Contact.initial().copyWith(
      emailAddress: email
    )
  ).toJson();

  Firestore
    .instance
    .collection("users")
    .document(id)
    .setData(user);
}

Future<void> addUsers(List<dynamic> allUsers) async {
  for (var user in allUsers) {
    Firestore
      .instance
      .collection("users")
      .document(user["id"])
      .setData(user);
  }
}

Future<void> updateUser(dynamic user) async {
  Firestore
    .instance
    .collection("users")
    .document(user["id"])
    .updateData(user);
}
