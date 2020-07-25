import 'package:flutter/material.dart';

const appTitle = "aspire";

enum AuthStatus {
  notDetermined,
  notLoggedIn,
  loggedIn,
}

Widget loadingScreen = Scaffold(
  body: Container(
    alignment: Alignment.center,
    child: CircularProgressIndicator(),
  ),
);