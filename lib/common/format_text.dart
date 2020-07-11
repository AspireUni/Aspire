import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormatText extends StatelessWidget {
  final String text;
  final Colors textColor;
  final double fontSize;
  final FontWeight fontWeight;

  FormatText({
    Key key, 
    @required this.text, 
    this.textColor, 
    this.fontSize, 
    this.fontWeight
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text, 
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: textColor ?? Colors.black,
          letterSpacing: .5, 
          fontSize: fontSize ?? 40.0,  
          fontWeight: fontWeight ?? FontWeight.bold
        )
      )
    );
  }
}