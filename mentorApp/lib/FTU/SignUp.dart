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
            // Navigate to second route when tapped.
            Navigator.pushNamed(context, '/Second');
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
      //appBar: AppBar(
        //title: Text("Second Route"),
      //),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
            Navigator.pushNamed(context, '/Filters');
          },
          child: Text('Done. Intialize filteres!'),
        ),
      ),
    );
  }
}
