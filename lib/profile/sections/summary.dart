import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:mentorApp/constants/profile_constants.dart';
import './header.dart';
 
class ProfileSummary extends StatelessWidget {  
  final String summary;
  ProfileSummary({Key key, @required this.summary}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 5.0,
            color: Colors.black12
          )
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeader(title: SECTION_TITLE_SUMMARY),
          buildSummary()
        ]
      )
    );
  }

  buildSummary() {
    return Text(
      summary,
      textAlign: TextAlign.left,
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.black54,
          letterSpacing: .5,
          height: 1.75,
          fontSize: 13.0,
          fontWeight: FontWeight.w600
        ),
      )
    );
  }
}