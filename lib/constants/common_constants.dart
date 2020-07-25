import 'package:flutter/material.dart';

const appName = "aspire";

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