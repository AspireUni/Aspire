import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/profile_constants.dart';
 
class ProfileHeader extends StatelessWidget {  
  final String fullName;
  ProfileHeader({Key key, @required this.fullName}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, 
      height: profileHeaderHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor, 
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0)
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            buildProfilePhoto(context),
            buildFullName()
          ]
        )
      ),
    );
  }

  buildProfilePhoto(BuildContext context) {
    return Container(
      width: 60.0, 
      height: 60.0, 
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor, 
        shape: BoxShape.circle
      )
    );
  }

  buildFullName() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Text> [
          Text(
            fullName,
            style: GoogleFonts.muli(
              textStyle: TextStyle(
                color: Colors.white, 
                letterSpacing: .5, 
                fontSize: 20.0, 
                fontWeight: FontWeight.bold
              ), 
            )
          )
        ]
      )
    );
  }
}