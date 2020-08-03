import 'package:flutter/material.dart';

const String appName = 'aspire';
const String nextButtonText = 'Next';

// Global header
const String addAction = 'Add';
const String skipAction = 'Skip';
const String filterAction = 'Filter';
const String signInAction = 'Sign in';
const String signUpAction = 'Sign up';
const String loginAction = 'Login';

const double globalHeaderFontSize = 22.0;
const double globalHeaderActionsFontSize = 16.0; 

// Modal
const String confirmModalAction = 'Confirm';

 // User types
enum UserType {
  mentor,
  mentee
}

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