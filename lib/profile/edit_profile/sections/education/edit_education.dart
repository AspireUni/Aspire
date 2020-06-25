import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../view_profile/sections/section.dart';
import './save_education.dart';


class EditEducation extends StatefulWidget {
  final List<Map<String, Object>> schools;
  EditEducation({Key key, @required this.schools}) : super(key: key);

  @override
  _EditEducationState createState() => _EditEducationState();
}

class _EditEducationState extends State<EditEducation> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          buildAddEducationRow(),
          buildSchoolList(context)
        ]
      )
    );
  }

  buildSchoolRow(BuildContext context, Map<String, Object> schoolInfo) {
    final String dateRange = "${schoolInfo['startYear']} - ${schoolInfo['endYear']}";
    final IconData edit = IconData(
      0xf2bf,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage
    );

    return InkWell(
      onTap: () => handleEditTap(context, schoolInfo),
      child: SectionRow(
        children: <Widget>[
          Row(
            children: <Widget> [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildEducationText(schoolInfo['school'], isSchool: true, isDateRange: false),
                    buildEducationText(schoolInfo['program'], isSchool: false, isDateRange: false),
                    buildEducationText(dateRange, isSchool: false, isDateRange: true)
                  ]
                )
              ),
              Container(
                padding: EdgeInsets.only(right: 5.0, left: 10.0),
                child: Icon(
                  edit,
                  color: Colors.black54,
                  size: 20.0,
                )
              ),
            ]
          )
        ]
      )
    );
  }

  buildSchoolList(BuildContext context) {
    List<Widget> schoolList = List<Widget>();
    for (int i = 0; i < widget.schools.length; i++) {
      schoolList.add(
        buildSchoolRow(
          context, 
          widget.schools[i]
        )
      );
    }

    return SectionList(children: schoolList);
  }

  buildEducationText(String text, {bool isSchool, bool isDateRange}) {
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

  buildAddEducationRow() {
    IconData add = IconData(
      0xf2c7,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage
    );
    return InkWell(
      onTap: () => handleAddTap(context),
      child: SectionRow(
        children: <Widget>[
          Row(
            children: <Widget> [
              Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  add,
                  color: Colors.black54,
                  size: 20.0,
                )
              ),
              Text(
                "Add education...",
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
        ]
      )
    );
  }
  handleAddTap(BuildContext context) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SaveEducation(
          editMode: false
        )
      )
    );
  }

  handleEditTap(BuildContext context, Map<String, Object> schoolInfo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SaveEducation(
          editMode: true,
          schoolInfo: schoolInfo
        )
      )
    );
  }
}
