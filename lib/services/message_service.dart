import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';
import 'services.dart';

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

  updateMatchesLastMessage(message, groupChatId);
}