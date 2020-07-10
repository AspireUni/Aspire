import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;
  final bool isSent;
  Message({Key key, @required this.message, @required this.isSent}) 
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
          color: isSent ? Theme.of(context).accentColor : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        margin: isSent 
          ? EdgeInsets.fromLTRB(50.0, 10.0, 10.0, 10.0) 
          : EdgeInsets.fromLTRB(10.0, 10.0, 50.0, 10.0),
        padding: EdgeInsets.all(10.0),
        child: Text(
          message,
          style: GoogleFonts.muli(
            textStyle: TextStyle(
              color: Colors.white, 
              letterSpacing: .5, 
              fontSize: 14.0, 
            )
          )
        )
      )
    );
  }
}