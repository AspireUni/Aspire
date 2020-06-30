import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle fieldTextStyle = GoogleFonts.muli(
  textStyle: TextStyle(
    color: Colors.black, 
    letterSpacing: .5, 
    fontSize: 13.0, 
  )
);

TextStyle buttonTextStyle = GoogleFonts.muli(
  textStyle: TextStyle(
    color: Colors.white, 
    letterSpacing: .5, 
    fontSize: 13.0, 
    fontWeight: FontWeight.w700
  )
);

TextStyle labelTextStyle({bool isEnabled}) => GoogleFonts.muli(
  textStyle: TextStyle(
    color: isEnabled ? Colors.black : Colors.black38, 
    letterSpacing: .5, 
    fontSize: 13.0, 
  )
);

TextStyle pickerTextStyle({bool isCancel, bool isButton}) => GoogleFonts.muli(
  textStyle: TextStyle(
    color: isCancel ? Colors.red : Colors.black, 
    letterSpacing: .5, 
    fontSize: 15.0,
    fontWeight: isButton ? FontWeight.w600 : FontWeight.normal
  )
);

InputDecoration fieldDecoration({String errorText}) => InputDecoration(
  isDense: true,
  contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0),
  errorText: errorText
);


