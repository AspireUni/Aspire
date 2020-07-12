import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/pairings_constants.dart';
import './pairings_card.dart';

class Pairings extends StatelessWidget {
  const Pairings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: Container(
          child: Center(
            child: Column(
              children: buildPairingsView(context)
            )
          )
        )
      )
    );
  }
}

buildPairingsView(BuildContext context) {
  return (
    <Widget>[
      ...buildHeader(), 
      PairingsCard()
    ]
  );
}

buildHeader() {
  return <Widget> [
    Text(
      pairingsHeaderTitle, 
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.black, 
          letterSpacing: .5, 
          fontSize: 40.0, 
          fontWeight: FontWeight.bold
        )
      )
    ),
    Text(
      pairingsSubtitle, 
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