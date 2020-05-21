import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
 
class ProfileInfo extends StatelessWidget {  
  final String info;
  ProfileInfo({Key key, @required this.info}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(60.0),
      child: Text(
        info,
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
    );
  }
}