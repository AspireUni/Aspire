import 'package:flutter/material.dart';

// TODO: Update this placeholder widget
class Skills extends StatelessWidget {  
  const Skills ({Key key}) : super(key: key);
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: Text("Skills", style: TextStyle(color: Colors.white, fontSize: 30.0))
        )
      )
    );
  }
}