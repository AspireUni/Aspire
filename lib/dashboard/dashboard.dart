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
                    children: buildDashboardView(context)
                  )
                )
              )
          )
        ]
      );
  }
}

// TODO: Generalize into reusable widgets (e.g. Title, subheader, etc)
buildDashboardView(BuildContext context) {
  return (
    <Widget>[
      ...buildHeader(), 
      ...buildPotentialMatch(context),
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
          fontSize: 18, 
          fontWeight: FontWeight.w600
        )
      )
    ), 
  ];
}

buildPotentialMatch(BuildContext context) {
  return <Container> [
    Container(
      child: Stack(
        alignment: FractionalOffset.bottomCenter,
        children: <Container>[
          buildDescriptionTextBox(), 
          buildNameTextBox(context)
        ]
      )
    )
  ];
}

buildDescriptionTextBox() {
  return Container(
    margin: const EdgeInsets.fromLTRB(60.0, 25.0, 60.0, 25.0),
    padding: const EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 90.0),
    child: Text(
      """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud.""",
      textAlign: TextAlign.left, 
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.black, 
          letterSpacing: .5, 
          height: 1.75,
          fontSize: 13.0, 
          fontWeight: FontWeight.w600
        ), 
      ) 
    ), 
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.grey[400],
        width: 0.75
      ),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0)
      ),
    )
  );
}

buildNameTextBox(BuildContext context) {
  return Container(
    width: 295.0, 
    height: 90.0, 
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget> [
        Container(
          width: 50.0, 
          height: 50.00, 
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor, 
            shape: BoxShape.circle
          )
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: <Widget> [
            Text(
              "Khalida Rafique",
              style: GoogleFonts.muli(
                textStyle: TextStyle(
                  color: Colors.white, 
                  letterSpacing: .5, 
                  fontSize: 21.0, 
                  fontWeight: FontWeight.bold
                ), 
              )
            ), 
            Text(
              "Mentor", 
                style: GoogleFonts.muli(
                textStyle: TextStyle(
                  color: Theme.of(context).accentColor,  
                  letterSpacing: .5, 
                  height: 1.5, 
                  fontSize: 15.0, 
                ), 
              )
            ) 
          ]
        )
      ]
    ),
      decoration: BoxDecoration(
        color: Colors.black, 
      border: Border.all(
        width: 3.0
      ),
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
          bottomLeft: Radius.elliptical(40.0, 40.0)
      ),
    )
  );
}