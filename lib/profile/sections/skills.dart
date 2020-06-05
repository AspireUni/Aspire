import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:mentorApp/constants/profile_constants.dart';
import './section.dart';
 
class ProfileSkills extends StatelessWidget {  
  final List<Map<String, Object>> skills;
  ProfileSkills({Key key, @required this.skills}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Section(
      title: SECTION_TITLE_SKILLS,
      child: buildSkillList(context)
    );
  }

  buildSkillRow(BuildContext context, String skill, double rating) {
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
          buildSkill(skill),
          buildRatingBar(context, rating)
        ]
      )
    );
  }

  buildSkillList(BuildContext context) {
    List<Widget> skillList = new List<Widget>();
    for (int i = 0; i < skills.length; i++) {
      skillList.add(
        buildSkillRow(
          context, 
          skills[i]["skill"],
          skills[i]["rating"]
        )
      );
    }

    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: skillList
      )
    );
  }

  buildSkill(String label) {
    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
        child: Text(
        label,
        textAlign: TextAlign.left,
        style: GoogleFonts.muli(
          textStyle: TextStyle(
            color: Colors.black,
            letterSpacing: .5,
            height: 1.2,
            fontSize: 13.0,
            fontWeight: FontWeight.w700
          ),
        )
      )
    );
  }

  buildRatingBar(BuildContext context, double rating) {
    return  LinearPercentIndicator(
      width: MediaQuery.of(context).size.width - 60.0,
      lineHeight: 9.0,
      percent: rating / 10,
      backgroundColor: Colors.black12,
      progressColor: Theme.of(context).accentColor,
      animation: true,
      animationDuration: 500,
    );
  }
}