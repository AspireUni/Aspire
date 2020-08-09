import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

import '../constants/constants.dart';
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

Future<QuerySnapshot> getVerifiedUsers() async {
  return Firestore
    .instance
    .collection("users")
    .where("isVerified", isEqualTo: true)
    .getDocuments();
}

Future<QuerySnapshot> getMentees() async {
  return Firestore
    .instance
    .collection("users")
    .where("type", isEqualTo: "mentee")
    .getDocuments();
}

Future<QuerySnapshot> getMentors() async {
  return Firestore
    .instance
    .collection("users")
    .where("type", isEqualTo: "mentor")
    .getDocuments();
}

Future<void> addMentee(
  String id, {
    String emailAddress,
    String fullName,
    String industry,
    List<String> areasOfInterest
  }
) async {
  var user = User.initial().copyWith(
    id: id,
    type: UserType.mentee,
    industry: industry,
    areas: areasOfInterest,
    fullName: fullName,
    emailAddress: emailAddress
  ).toJson();

  Firestore
    .instance
    .collection("users")
    .document(id)
    .setData(user);
}

Future<void> addMentor(
  String id, {
    String emailAddress,
    String fullName,
    String industry,
    List<String> areasOfExpertise,
    String company,
    String jobTitle,
    String startDate
  }
) async {
  var user = User.initial().copyWith(
    id: id,
    type: UserType.mentor,
    industry: industry,
    areas: areasOfExpertise,
    fullName: fullName,
    emailAddress: emailAddress,
    jobs: [
      Job(
        id: randomAlphaNumeric(15), 
        title: jobTitle,
        company: company,
        startDate: startDate,
        endDate: endDatePresent
      )
    ]
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

Future<void> verifyUser(String userId) async {
  var data = {
    'id': userId,
    'isVerified': true
  };
  Firestore
    .instance
    .collection("users")
    .document(userId)
    .updateData(data);
}
