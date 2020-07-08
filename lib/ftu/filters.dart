import 'package:flutter/material.dart';

// TODO: Update this placeholder widget
class Filters extends StatelessWidget {
  const Filters({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Select up to 3 options", 
          style: TextStyle(color: Colors.white, fontSize: 20.0)
        )
      ),
      body: InkWell(
        onTap: (){
          Scaffold.of(context);
        },
        child: Container(
          padding: EdgeInsets.all(12.0),
          child: Text('Flat Button', style: TextStyle(color: Colors.white)),
        )
      )
    );
  }
}
