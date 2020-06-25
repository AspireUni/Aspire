import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
 
class SectionHeader extends StatelessWidget {  
  final String title;
  SectionHeader({Key key, @required this.title}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: GoogleFonts.muli(
          textStyle: TextStyle(
            color: Colors.black, 
            letterSpacing: .5, 
            fontSize: 18.0, 
            fontWeight: FontWeight.w600,
          ),
        )
      )
    );
  }
}