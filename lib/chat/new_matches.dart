import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../constants/chat_constants.dart';
import './chat_messenger.dart';

const dummyData = [
  {
    "name": "Charles",
    "color": Colors.blue,
  },
  {
    "name": "Rebecca",
    "color": Colors.purple,
  },
  {
    "name": "Mike",
    "color": Colors.green,
  },
  {
    "name": "Hawk",
    "color": Colors.orange,
  },
  {
    "name": "Pat",
    "color": Colors.yellow,
  },
  {
    "name": "Maweenie",
    "color": Colors.red,
  },
  {
    "name": "Simp",
    "color": Colors.indigo,
  },
  {
    "name": "Igotalongnamewowitisreallysosolong",
    "color": Colors.black,
  },
];

class NewMatches extends StatelessWidget {
  NewMatches({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            chatNewMatchesTitle, 
            textAlign: TextAlign.left,
            style: GoogleFonts.muli(
              textStyle: TextStyle(
                color: Colors.black, 
                letterSpacing: .5, 
                fontSize: 18.0, 
                fontWeight: FontWeight.bold
              )
            )
          )
        ),
        buildNewMatches(context),
      ]
    );
  }
}

buildNewMatches(context) {
  List<Widget> newMatchesList = <Widget>[];
  for (int i = 0; i < dummyData.length; i++) {
    newMatchesList.add(
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => 
              ChatMessenger(recipient: dummyData[i]["name"])
            )
          );
        },
        child: Container(
          width: 80.0,
          height: 80.0,
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Container(
                width: 60.0, 
                height: 60.0, 
                decoration: BoxDecoration(
                  color: dummyData[i]["color"], 
                  shape: BoxShape.circle
                )
              ),
              Text(
                dummyData[i]["name"],
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.muli(
                  textStyle: TextStyle(
                    color: Colors.black, 
                    letterSpacing: .5, 
                    fontSize: 12.0, 
                    fontWeight: FontWeight.w600
                  )
                )
              )
            ]
          )
        )
      ),
    );
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: newMatchesList,
    )
  );
}