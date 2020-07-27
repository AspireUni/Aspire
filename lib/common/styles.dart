import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration loginFieldDecoration(
  BuildContext context, {
    String hintText,
    IconData icon,
    bool isFocused,
    bool isInvalid
  }
) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(0),
    isDense: true, 
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey,
        width: 1.0
      ),
      borderRadius: BorderRadius.all(Radius.zero),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
        width: 1.0
      ),
      borderRadius: BorderRadius.all(Radius.zero),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red,
        width: isFocused ? 2.0 : 1.0
      ),
      borderRadius: BorderRadius.all(Radius.zero),
    ),
    errorStyle: fieldTextStyle(fontSize: 13.0, color: Colors.red),
    hintText: hintText,
    hintStyle: fieldTextStyle(),
    prefixIcon: Icon(
      icon,
      color: isFocused && !isInvalid 
      ? Theme.of(context).accentColor
      : Colors.grey,
      size: 20.0
    )
  );
}

TextStyle fieldTextStyle({double fontSize, Color color}) =>
  GoogleFonts.muli(
    textStyle: TextStyle(
      color: color ?? Colors.grey,
      letterSpacing: .5, 
      fontSize: fontSize ?? 14.0,  
      fontWeight: FontWeight.w500,
      height: 1.2
    )
  );