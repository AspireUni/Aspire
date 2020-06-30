import 'package:flutter/material.dart';

import '../Navigation/app_controller.dart';
import './authentication.dart';
import './signuplogin.dart';

enum AuthStatus {
  notDetermined,
  notLoggedIn,
  loggedIn,
}

class RootPage extends StatefulWidget {
  RootPage({this.auth});

  final BaseAuth auth;

  @override
  State<StatefulWidget> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.notDetermined;
  String _userId = "";

  @override
  void initState() {
    super.initState();
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        if (user != null) {
          _userId = user.uid;
        }
        authStatus =
            user?.uid == null ? AuthStatus.notLoggedIn : AuthStatus.loggedIn;
      });
    });
  }

  void loginCallback() {
    widget.auth.getCurrentUser().then((user) {
      setState(() {
        _userId = user.uid.toString();
      });
    });
    setState(() {
      authStatus = AuthStatus.loggedIn;
    });
  }

  void logoutCallback() {
    setState(() {
      authStatus = AuthStatus.notLoggedIn;
      _userId = "";
    });
  }

  Widget buildWaitingScreen() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    switch (authStatus) {
      case AuthStatus.notDetermined:
        return buildWaitingScreen();
        break;
      case AuthStatus.notLoggedIn:
        return LoginSignupPage(
          auth: widget.auth,
          loginCallback: loginCallback,
        );
        break;
      case AuthStatus.loggedIn:
        if (_userId != null && _userId.length > 0) {
          return AppController(
            userId: _userId,
            auth: widget.auth,
            logoutCallback: logoutCallback,
          );
        } else {
          return buildWaitingScreen();
        }
        break;
      default:
        return buildWaitingScreen();
    }
  }
}
