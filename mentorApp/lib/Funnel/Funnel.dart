import 'package:flutter/material.dart';

class Funnel extends StatelessWidget {
  const Funnel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        child: Center(
          child: Text("Sign up funnel", style: TextStyle(color: Colors.white, fontSize: 30.0))
        )
      )
    );
  }

}
