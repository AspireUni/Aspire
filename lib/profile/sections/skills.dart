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

  buildSkillRow(BuildContext context, String skill, String level) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
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
          buildSkillText(skill, true),
          buildSkillText(level, false)
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
          skills[i]["level"]
        )
      );
    }

    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: skillList
      )
    );
  }

  buildSkillText(String text, bool isSkill) {
    return Container(
        child: Text(
        text,
        textAlign: TextAlign.left,
        style: GoogleFonts.muli(
          textStyle: TextStyle(
            color: isSkill ? Colors.black : Colors.black54,
            letterSpacing: .5,
            height: 1.2,
            fontSize: 13.0,
            fontWeight: isSkill ? FontWeight.w700 : FontWeight.w500
          ),
        )
      )
    );
  }

 
}