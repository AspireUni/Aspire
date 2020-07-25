import 'package:cloud_firestore/cloud_firestore.dart';

Future getUser(id) async {
  return (await Firestore
    .instance
    .collection("users")
    .document(id)
    .get()).data;
}

Future getUsers() async {
  Firestore
    .instance
    .collection("users")
    .getDocuments();
}

Future addUser(user) async {
  Firestore
    .instance
    .collection("users")
    .document(user["id"])
    .setData(user);
}

Future addUsers(allUsers) async {
  for (var user in allUsers) {
    Firestore
      .instance
      .collection("users")
      .document(user["id"])
      .setData(user);
  }
}

Future updateUser(user) async {
  Firestore
    .instance
    .collection("users")
    .document(user["id"])
    .updateData(user);
}
