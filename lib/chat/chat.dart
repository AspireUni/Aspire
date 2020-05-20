import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import './new_matches.dart';
import './messages.dart';

// TODO: Update this placeholder widget
class Chat extends StatelessWidget {
  const Chat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/DefaultBg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(0),
            child: Center(
              child: Column(
                children: buildChatView()
              )
            )
          )
        ),
      ]
    );
  }
}

buildHeader() {
  return <Text> [
    Text(
      "Chat", 
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.black, 
          letterSpacing: .5, 
          fontSize: 30.0, 
          fontWeight: FontWeight.bold
        )
      )
    ), 
    Text(
      "Connect with your matches", 
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.grey, 
          letterSpacing: .5, 
          fontSize: 18, 
          fontWeight: FontWeight.w600
        )
      )
    ), 
  ];
}

buildChatView() {
  return (
    <Widget>[
      ...buildHeader(),
      NewMatches(

      ),
      Messages(

      )
    ]
  );
}