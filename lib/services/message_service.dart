import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/models.dart';
import 'services.dart';

Future<void> addMessage(Message message, String groupChatId) async {
  var messageJson = message.toJson();

  Firestore
    .instance
    .collection('messages')
    .document(groupChatId)
    .collection(groupChatId)
    .add(messageJson);

  updateMatchesLastMessage(messageJson, groupChatId);
}