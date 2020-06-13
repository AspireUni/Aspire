import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aspire/constants/profile_constants.dart';
import './section.dart';
 
class ProfileExperience extends StatelessWidget {  
  final List<Map<String, Object>> jobs;
  ProfileExperience({Key key, @required this.jobs}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Section(
      title: sectionTitleExperience,
      child: buildJobList(context)
    );
  }

  buildJobRow(BuildContext context, String jobTitle, String company, String startDate, String endDate) {
    final String dateRange = startDate + " - " + endDate;

    return SectionRow(
      children: <Widget>[
        buildExperienceText(jobTitle, true, false),
        buildExperienceText(company, false, false),
        buildExperienceText(dateRange, false, true)
      ]
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

    return SectionList(children: jobList);
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