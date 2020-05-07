import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

// TODO: Update this placeholder widget
class Dashboard extends StatelessWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: <Widget>[
          Image.asset(
            "images/DashboardBg.png",
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
                child: Center(
                  child: Column(
                    children: buildDashboardView()
                  )
                )
              )
          )
        ]
      );
  }
}

// TODO: Generalize into reusable widgets (e.g. Title, subheader, etc)
buildDashboardView() {
  return (
    <Widget>[
      ...buildHeader(), 
      buildCurrentMatch(),
    ]
  );
}

buildHeader() {
  return <Text> [
    Text(
      "Pairings", 
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
      "Browse your matches", 
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.grey, 
          letterSpacing: .5, 
          fontSize: 20, 
          fontWeight: FontWeight.w600
        )
      )
    ), 
  ];
}

buildCurrentMatch() {
  return Container(
    margin: const EdgeInsets.fromLTRB(60.0, 75.0, 60.0, 60.0),
    padding: const EdgeInsets.all(25.0),
    child: Text(
      """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud""",
      textAlign: TextAlign.left, 
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.black, 
          letterSpacing: .5, 
          height: 1.75,
          fontSize: 13.0, 
          fontWeight: FontWeight.bold
        ), 
      ) 
    ), 
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey[400],
        width: 0.75
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(10.0)
      ),
    )
  );
}