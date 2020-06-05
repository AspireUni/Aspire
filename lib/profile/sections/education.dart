import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:mentorApp/constants/profile_constants.dart';
import './section.dart';

 
class ProfileEducation extends StatelessWidget {  
  final List<Map<String, Object>> schools;
  ProfileEducation({Key key, @required this.schools}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Section(
      title: SECTION_TITLE_EDUCATION,
      child: buildSchoolList(context)
    );
  }

  buildSchoolRow(BuildContext context, String school, String program, String startYear, String endYear) {
    final String dateRange = startYear + " - " + endYear;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12
          )
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildEducationText(school, true, false),
          buildEducationText(program, false, false),
          buildEducationText(dateRange, false, true)
        ]
      )
    );
  }

  buildSchoolList(BuildContext context) {
    List<Widget> schoolList = new List<Widget>();
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

    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: schoolList
      )
    );
  }

  buildEducationText(String text, bool isSchool, bool isDateRange) {
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