import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateMatchesLastMessage(
  message,
  groupChatId
) async {
  Firestore
    .instance
    .collection("matches")
    .document(groupChatId)
    .updateData({'lastMessage': message, 'hasContacted': true});
}

Future<QuerySnapshot> getMatches(String uid, isMentee) async {
  if (isMentee == true) {
    return Firestore
      .instance
      .collection("matches")
      .where('mentee.id', isEqualTo: uid)
      .getDocuments();
  } else {
    return Firestore
      .instance
      .collection("matches")
      .where('mentor.id', isEqualTo: uid)
      .getDocuments();
  }
}

Future<QuerySnapshot> getMatch(String menteeId, String mentorId) async {
  return Firestore
    .instance
    .collection("matches")
    .where('mentee.id', isEqualTo: menteeId)
    .where('mentor.id', isEqualTo: mentorId)
    .getDocuments();
}