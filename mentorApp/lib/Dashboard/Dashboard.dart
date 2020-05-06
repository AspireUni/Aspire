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
          fontWeight: FontWeight.bold
        )
      )
    ), 
  ];
}

