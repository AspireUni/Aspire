import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/profile_constants.dart';
import './section.dart';
 
class ProfileSkills extends StatelessWidget {  
  final List<Map<String, Object>> skills;
  ProfileSkills({Key key, @required this.skills}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Section(
      title: sectionTitleSkills,
      child: buildSkillList(context)
    );
  }

  buildSkillRow(BuildContext context, String skill, String level) {
    return SectionRow(
      children: <Widget>[
        buildSkillText(skill, isSkill: true),
        buildSkillText(level, isSkill: false)
      ]
    );
  }

  buildSkillList(BuildContext context) {
    List<Widget> expertList = List<Widget>();
    List<Widget> intermediateList = List<Widget>();
    List<Widget> beginnerList = List<Widget>();

    for (int i = 0; i < skills.length; i++) {
      if (skills[i]["level"] == skillExpert){
        expertList.add(
          buildSkillRow(
            context, 
            skills[i]["skill"],
            skillExpert
          )
        );
      } else if (skills[i]["level"] == skillIntermediate){
        intermediateList.add(
          buildSkillRow(
            context, 
            skills[i]["skill"],
            skillIntermediate
          )
        );
      } else if (skills[i]["level"] == skillBeginner){
        beginnerList.add(
          buildSkillRow(
            context, 
            skills[i]["skill"],
            skillBeginner
          )
        );
      }
    }

  List<Widget> skillList = [
    ...expertList, 
    ...intermediateList, 
    ...beginnerList
  ];

    return SectionList(children: skillList);
  }

  buildSkillText(String text, {bool isSkill}) {
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