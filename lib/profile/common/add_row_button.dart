import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/section.dart';
import '../common/styles.dart';

class AddRowButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  
  AddRowButton({Key key, @required this.text, @required this.onTap}) 
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SectionRow(
        children: <Widget> [
          Container(
            padding: EdgeInsets.only(right: 10.0),
            child: addIcon
          ),
          Text(
            text,
            textAlign: TextAlign.left,
            style: GoogleFonts.muli(
              textStyle: TextStyle(
                color: Colors.black54,
                letterSpacing: .5,
                height: 1.3,
                fontSize: 15.0,
              ),
            )
          )
        ]
      )
    );
  }
}
