import 'package:flutter/material.dart';

// TODO: Update this placeholder widget
class SignUp extends StatelessWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        title: new Text("Filters", style: TextStyle(color: Colors.white, fontSize: 30.0))
      ),
      body: InkWell(
        onTap: (){
          Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Tap'),));
        },
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Text('Flat Button', style: TextStyle(color: Colors.white)),
      )
      )
      );
  }
}
