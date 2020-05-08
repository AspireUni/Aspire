import 'package:flutter/material.dart';

class Completed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //appBar: AppBar(
        //title: Text('First Route'),
      //),
      body: Center(
        child: RaisedButton(
          //child: Container(decoration: new BoxDecoration(color: Colors.black)),
          child: Text("Congrats, you have completed sign-up", style: TextStyle(color: Colors.black) ),
          onPressed: () {
            // Navigate to second route when tapped.
            Navigator.pushNamed(context, '/Profiles');
          },
        ),
      ),
    );
  }
}