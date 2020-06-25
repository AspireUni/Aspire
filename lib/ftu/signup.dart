import 'package:flutter/material.dart';

import "../helpers/dummy_data.dart";    // temporary to test the firestore
import "../helpers/post_users.dart";

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RaisedButton(
          child: Text('Sign-Up', style: TextStyle(color: Colors.black) ),
          onPressed: () {
            Navigator.pushNamed(context, '/second');
          },
        ),
      ),
    );
  }
}


class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            navigateToProfile(context);
          },
          child: Text('Done. To the profile!'),
        ),
      ),
    );
  }
}

void navigateToProfile(context) {
  postUsers(dummyUsers);
  Navigator.pushNamed(context, '/Pairings');
}