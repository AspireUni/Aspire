import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
 
class ProfileHeader extends StatelessWidget {  
  final String fullName, emailAddress;
  ProfileHeader({Key key, @required this.fullName, @required this.emailAddress}) : super(key: key);
  
  @override
    Widget build(BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width, 
        height: 200.0, 
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Container(
              width: 60.0, 
              height: 60.0, 
              decoration: BoxDecoration(
                color: Color(0xFF45CAB9), 
                shape: BoxShape.circle
              )
            ),
            Container(
              margin: const EdgeInsets.only(top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Text> [
                  Text(
                    fullName,
                    style: GoogleFonts.muli(
                      textStyle: TextStyle(
                        color: Colors.white, 
                        letterSpacing: .5, 
                        fontSize: 30.0, 
                        fontWeight: FontWeight.bold
                      ), 
                    )
                  ), 
                  Text(
                    emailAddress, 
                      style: GoogleFonts.muli(
                      textStyle: TextStyle(
                        color: Colors.white,  
                        letterSpacing: .5, 
                        height: 1.5, 
                        fontSize: 14.0, 
                      ), 
                    )
                  )
                ]
              )
            )
          ]
        ),
          decoration: BoxDecoration(
            color: Color(0xFF0F1236), 
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
}