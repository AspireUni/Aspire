import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Funnel extends StatelessWidget {
  const Funnel({Key key}) : super(key: key);

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
                    children: buildFunnelView()
                  )
                )
              )
          )
        ]
      );
  }

  buildFunnelView(){
      return (
    <Widget>[
      ...mentorFunnel(), 
      ...menteeFunnel(),
      ]
    );
  }
  
  mentorFunnel(){
  return <Text>[
    Text(
      "I am a Mentor", 
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.black, 
          letterSpacing: .5, 
          fontSize: 40.0, 
          fontWeight: FontWeight.bold
        )
      )
    )
    ];
  }

  menteeFunnel(){
      return <Text>[
        Text(
      "I am a Mentee", 
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.black, 
          letterSpacing: .5, 
          fontSize: 40.0, 
          fontWeight: FontWeight.bold
        )
      )
    )
    ];
  }

}
