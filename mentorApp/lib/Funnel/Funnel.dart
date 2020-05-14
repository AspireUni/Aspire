import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentorApp/AppController.dart';

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
                margin: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Column(
                    children: buildFunnelView(context)
                  )
                )
              )
          )
        ]
      );
  }

  buildFunnelView(BuildContext context){
   return <Widget>[
          Text(
            "Welcome", 
              style: GoogleFonts.muli(
                textStyle: TextStyle(
                color: Colors.black, 
                letterSpacing: .5, 
                  fontSize: 40.0, 
                fontWeight: FontWeight.bold,
              )
            )
          ),
          Container(
            margin: const EdgeInsets.only(top: 60.0),
            child: new RaisedButton(
            color: Colors.black,
            padding: EdgeInsets.all(30.0),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
            ),
            onPressed: () {
              //TODO: navigate to mentor sign up page
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppController())
                );
              },
            //TODO: reuse this text style
            child: Text('I am a mentee', 
              style: GoogleFonts.muli(
                textStyle: TextStyle(
                color: Colors.white, 
                letterSpacing: .5, 
                fontSize: 20.0, 
                fontWeight: FontWeight.normal
                )
              )
            ),
            ),
          ),
          const SizedBox(height: 30),
          RaisedButton(
            color: Colors.black,
            padding: EdgeInsets.all(30.0),
            shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
            ),
            onPressed: () {
              //TODO: navigate to mentee sign up page
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppController())
                );
              },
            //TODO: reuse this text style
            child: Text('I am a mentor', 
              style: GoogleFonts.muli(
                textStyle: TextStyle(
                color: Colors.white, 
                letterSpacing: .5, 
                fontSize: 20.0, 
                fontWeight: FontWeight.normal
                )
              )
            ),
          ),
        ];
  }

}

