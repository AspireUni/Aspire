import 'package:flutter/material.dart';

class FirstRoute extends StatelessWidget {
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
          child: Text('Sign-Up', style: TextStyle(color: Colors.black) ),
          onPressed: () {
            Navigator.pushNamed(context, '/funnel');
          },
        ),
      ),
    );
  }
}

