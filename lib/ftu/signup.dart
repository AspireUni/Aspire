import 'package:flutter/material.dart';

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
            Navigator.pushNamed(context, '/UserProfile');
          },
          child: Text('Done. To the profile!'),
        ),
      ),
    );
  }
}
