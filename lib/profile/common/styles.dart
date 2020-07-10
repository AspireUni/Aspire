import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/profile_constants.dart';

TextStyle fieldTextStyle = GoogleFonts.muli(
  textStyle: TextStyle(
    color: Colors.black, 
    letterSpacing: .5, 
    fontSize: 13.0, 
  )
);

TextStyle deleteButtonTextStyle = GoogleFonts.muli(
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
  contentPadding: EdgeInsets.only(
    top: 5.0,
    bottom: 5.0
  ),
  errorText: errorText
);


Icon addIcon = Icon(
  IconData(
    plusIconCodePoint,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  ),
  color: Colors.black54,
  size: 20.0,
);

IconData editIconInRow = IconData(
  rowEditIconCodePoint,
  fontFamily: CupertinoIcons.iconFont,
  fontPackage: CupertinoIcons.iconFontPackage
);

Widget editButtonInRow = Container(
  padding: EdgeInsets.only(
    right: 5.0,
    left: 10.0
  ),
  child: Icon(
    editIconInRow,
    color: Colors.black54,
    size: 20.0,
  )
);


