import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class SchoolRow extends StatelessWidget {
  final  Map<String, Object> schoolInfo;
  SchoolRow({Key key, @required this.schoolInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String dateRange = "${schoolInfo['startYear']} - ${schoolInfo['endYear']}";

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildSchoolText(
            schoolInfo['school'],
            isSchool: true,
            isDateRange: false
          ),
          buildSchoolText(
            schoolInfo['program'],
            isSchool: false,
            isDateRange: false
          ),
          buildSchoolText(
            dateRange,
            isSchool: false,
            isDateRange: true
          )
        ]
      )
    );
  }

  buildSchoolText(String text, {bool isSchool, bool isDateRange}) {
    return Text(
      text,
      textAlign: TextAlign.left,
      softWrap: true,
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: isDateRange ? Colors.black54 : Colors.black,
          letterSpacing: .5,
          height: 1.2,
          fontSize: 13.0,
          fontWeight: isSchool ? FontWeight.w700 : FontWeight.w500
        ),
      )
    );
  }
}
