import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/profile_constants.dart';
import './section.dart';

 
class ProfileEducation extends StatelessWidget {  
  final List<Map<String, Object>> schools;
  ProfileEducation({Key key, @required this.schools}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Section(
      title: sectionTitleEducation,
      child: buildSchoolList(context)
    );
  }

  buildSchoolRow(BuildContext context, String school, String program, String startYear, String endYear) {
    final String dateRange = "$startYear - $endYear";

    return SectionRow(
      children: <Widget>[
        buildEducationText(school, isSchool: true, isDateRange: false),
        buildEducationText(program, isSchool: false, isDateRange: false),
        buildEducationText(dateRange, isSchool: false, isDateRange: true)
      ]
    );
  }

  buildSchoolList(BuildContext context) {
    List<Widget> schoolList = <Widget>[];
    for (int i = 0; i < schools.length; i++) {
      schoolList.add(
        buildSchoolRow(
          context, 
          schools[i]["school"], 
          schools[i]["program"], 
          schools[i]["startYear"],
          schools[i]["endYear"]
        )
      );
    }

    return SectionList(children: schoolList);
  }

  buildEducationText(String text, {bool isSchool, bool isDateRange}) {
    return Text(
      text,
      textAlign: TextAlign.left,
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