import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> authSignIn(String email, String password) async {
  var result = await FirebaseAuth
    .instance
    .signInWithEmailAndPassword(
      email: email,
      password: password
    );
  return result.user.uid;
}

Future<String> authSignUp(String email, String password) async {
  var result = await FirebaseAuth
    .instance
    .createUserWithEmailAndPassword(
      email: email,
      password: password
    );
  return result.user.uid;
}

Future<FirebaseUser> getCurrentAuthUser() async {
  var user = await FirebaseAuth
    .instance
    .currentUser();
  if (user != null) {
    if (!user.isEmailVerified) {
      return null;
    }
  }
  return user;
}

Future<void> authSignOut() async {
  await FirebaseAuth
    .instance
    .signOut();
}

Future<void> sendEmailVerification() async {
  var user = await FirebaseAuth
    .instance
    .currentUser();
  user.sendEmailVerification();
}

Future<void> resetPassword(String email) async {
  await FirebaseAuth
    .instance
    .sendPasswordResetEmail(
      email: email
    );
}

Future<bool> isEmailVerified() async {
  var user = await FirebaseAuth
    .instance
    .currentUser();
  return user.isEmailVerified;
}
