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

Stream<QuerySnapshot> getMessageSnapshots(
  String groupChatId, 
  int messageLimit
) {
  return Firestore.instance
    .collection('messages')
    .document(groupChatId)
    .collection(groupChatId)
    .orderBy('timestamp', descending: true)
    .limit(messageLimit)
    .snapshots();
}

Future<QuerySnapshot> getMessagesOlderThanTimestamp(
  String groupChatId,
  String timestamp,
) async {
  return Firestore.instance
    .collection('messages')
    .document(groupChatId)
    .collection(groupChatId)
    .where('timestamp', isLessThan: timestamp)
    .orderBy('timestamp', descending: true)
    .limit(20)
    .getDocuments();
}