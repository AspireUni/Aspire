import 'package:flutter/material.dart';

const appName = "aspire";
const nextButtonText = "Next";
const addButtonText = "Add";
const skipButtonText = "Skip";

// Global header
const skipAction = "Skip";
const filterAction = "Filter";
const signUpAction = "No account? Sign up here.";

const globalHeaderFontSize = 22.0;
const globalHeaderActionsFontSize = 16.0; 

 // Authentication
enum AuthStatus {
  notDetermined,
  notLoggedIn,
  loggedIn,
}

// Loading screen
Widget loadingScreen = Scaffold(
  body: Container(
    alignment: Alignment.center,
    child: CircularProgressIndicator(),
  ),
);