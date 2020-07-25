import 'package:cloud_firestore/cloud_firestore.dart';

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

Future<void> addUser(String id, String email) async {
  var user = User.initial().copyWith(
    id: id,
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

Future<void> addMessage(
  String idFrom, 
  String idTo, 
  String content, 
  int type,
  String groupChatId
) async {
  var message = Message(
    idTo: idTo,
    idFrom: idFrom,
    content: content,
    type: type,
    timestamp: DateTime.now().millisecondsSinceEpoch.toString()
  ).toJson();

  Firestore
    .instance
    .collection('messages')
    .document(groupChatId)
    .collection(groupChatId)
    .add(message);
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

// Future<void> getMatches() async {
//   Firestore
//     .instance
//     .collection("matches")
//     .document()
// }
