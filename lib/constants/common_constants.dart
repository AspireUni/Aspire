import 'package:flutter/material.dart';

const appName = "aspire";
const nextButtonText = "Next";

// Global header
const addAction = 'Add';
const skipAction = 'Skip';
const filterAction = 'Filter';
const signInAction = 'Sign in';
const signUpAction = 'Sign up';
const loginAction = 'Login';

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