import 'package:flutter/material.dart';

// TODO: Update this placeholder widget
class UserProfile extends StatelessWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Text("User Profile", style: TextStyle(color: Colors.white, fontSize: 30.0))
        )
      )
      );
  }
}