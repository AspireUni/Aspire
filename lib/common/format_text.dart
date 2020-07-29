import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormatText extends StatelessWidget {
  final String text;
  final Color textColor;
  final TextAlign textAlign;
  final double fontSize;
  final FontWeight fontWeight;
  final double fontHeight;
  final TextOverflow overflow;
  final int maxLines;

  FormatText({
    Key key, 
    @required this.text, 
    this.textColor,
    this.textAlign,
    this.fontSize, 
    this.fontWeight, 
    this.fontHeight,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.left,
      overflow: overflow,
      maxLines: maxLines,
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: textColor ?? Colors.black,
          letterSpacing: .5, 
          fontSize: fontSize ?? 40.0,  
          fontWeight: fontWeight ?? FontWeight.bold,
          height: fontHeight ?? 1.2
        )
      )
    );
  }
}