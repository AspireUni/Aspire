import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './common_context.dart';

InputDecoration fieldDecoration(
  BuildContext context, {
    String hintText,
    String errorText,
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
        color: ThemeColors.accent,
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
    errorText: errorText,
    errorStyle: fieldTextStyle(
      fontSize: 13.0,
      color: Colors.red
    ),
    hintText: hintText,
    hintStyle: fieldTextStyle(),
    prefixIcon: Icon(
      icon,
      color: isFocused && !isInvalid 
      ? ThemeColors.accent
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

TextStyle modalTextStyle({bool isButton, Color color}) =>
  GoogleFonts.muli(
    textStyle: TextStyle(
      color: color ?? Colors.grey, 
      letterSpacing: .5, 
      fontSize: 15.0,
      fontWeight: isButton ? FontWeight.w600 : FontWeight.normal
    )
  );