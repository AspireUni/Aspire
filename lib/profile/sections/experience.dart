import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mentorApp/constants/profile_constants.dart';
import './header.dart';
 
class ProfileExperience extends StatelessWidget {  
  final List<Map<String, Object>> jobs;
  ProfileExperience({Key key, @required this.jobs}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 20.0),
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
          SectionHeader(title: sectionTitleExperience),
          buildJobList(context)
        ],
      )
    );
  }


  buildJobRow(BuildContext context, String jobTitle, String company, String startDate, String endDate) {
    final String dateRange = startDate + " - " + endDate;

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
          buildExperienceText(jobTitle, true, false),
          buildExperienceText(company, false, false),
          buildExperienceText(dateRange, false, true)
        ]
      )
    );
  }

  buildJobList(BuildContext context) {
    List<Widget> jobList = new List<Widget>();
    for (int i = 0; i < jobs.length; i++) {
      jobList.add(
        buildJobRow(
            context, 
            jobs[i]["jobTitle"], 
            jobs[i]["company"], 
            jobs[i]["startDate"],
            jobs[i]["endDate"]
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: jobList
    );
  }

  buildExperienceText(String text, bool isJobTitle, bool isDateRange) {
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