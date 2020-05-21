import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
 
class ProfileBio extends StatelessWidget {  
  final String bio;
  ProfileBio({Key key, @required this.bio}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Text(
        bio,
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
      )
    );
  }
}