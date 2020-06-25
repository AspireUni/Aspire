import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../view_profile/sections/section.dart';

class EditExperience extends StatefulWidget {
  final List<Map<String, Object>> jobs;
  EditExperience({Key key, @required this.jobs}) : super(key: key);

  @override
  _EditExperienceState createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {
  ValueChanged _onChanged = (val) => print(val);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          buildAddExperienceRow(),
          buildJobList(context)
        ]
      )
    );
  }

    buildAddExperienceRow() {
    IconData add = IconData(
      0xf2c7,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage
    );
    return InkWell(
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
                "Add experience...",
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

  buildJobRow(BuildContext context, String jobTitle, String company, String startDate, String endDate) {
    final String dateRange = "$startDate - $endDate";
     final IconData edit = IconData(
      0xf2bf,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage
    );

    return InkWell(
      child: SectionRow(
        children: <Widget>[
          Row(
            children: <Widget> [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildExperienceText(jobTitle, isJobTitle: true, isDateRange: false),
                    buildExperienceText(company, isJobTitle: false, isDateRange: false),
                    buildExperienceText(dateRange, isJobTitle: false, isDateRange: true)
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

  buildJobList(BuildContext context) {
    List<Widget> jobList = List<Widget>();
    for (int i = 0; i < widget.jobs.length; i++) {
      jobList.add(
        buildJobRow(
            context, 
            widget.jobs[i]["jobTitle"], 
            widget.jobs[i]["company"], 
            widget.jobs[i]["startDate"],
            widget.jobs[i]["endDate"]
        ),
      );
    }

    return SectionList(children: jobList);
  }

  buildExperienceText(String text, {bool isJobTitle, bool isDateRange}) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: isDateRange ? Colors.black54 : Colors.black,
          letterSpacing: .5,
          height: 1.2,
          fontSize: 13.0,
          fontWeight: isJobTitle ? FontWeight.w700 : FontWeight.w500
        ),
      )
    );
  }
}
