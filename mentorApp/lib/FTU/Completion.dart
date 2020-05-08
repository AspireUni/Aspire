import 'package:flutter/material.dart';

class Completed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: RaisedButton(
          child: Text("Congrats, you have completed sign-up!", style: TextStyle(color: Colors.black) ),
          onPressed: () {
            Navigator.pushNamed(context, '/profiles');
          },
        ),
      ),
    );
  }
}