import 'package:flutter/material.dart';
import 'package:mentorApp/AppController.dart';
//import 'package:google_fonts/google_fonts.dart';

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
          RaisedButton(
            onPressed: () {
              //TODO: navigate to mentor sign up page
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppController())
                );
              },
            child: Text('I am a mentor', style: TextStyle(fontSize: 20)),
          ),
          const SizedBox(height: 30),
          RaisedButton(
            onPressed: () {
              //TODO: navigate to mentee sign up page
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AppController())
                );
              },
            child: const Text('I am a mentee', style: TextStyle(fontSize: 20)),
          ),
        ];
  }

  routeToMentorHomePage(){

  }

}

