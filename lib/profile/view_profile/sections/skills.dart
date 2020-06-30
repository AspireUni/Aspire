import 'package:flutter/material.dart';

import '../../../constants/profile_constants.dart';
import '../../common/section.dart';
import '../../common/skill_row.dart';
 
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

  Widget buildSkillList(BuildContext context) {
    List<Widget> expertList = <Widget>[];
    List<Widget> intermediateList = <Widget>[];
    List<Widget> beginnerList = <Widget>[];

    // Temporary workaround for sorting skills
    for (int i = 0; i < skills.length; i++) {
      if (skills[i]["level"] == skillExpert){
        expertList.add(
          SectionRow(children: <Widget>[SkillRow(skillInfo: skills[i])]
          )
        );
      } else if (skills[i]["level"] == skillIntermediate){
        intermediateList.add(
          SectionRow(children: <Widget>[SkillRow(skillInfo: skills[i])])
        );
      } else if (skills[i]["level"] == skillBeginner){
        beginnerList.add(
          SectionRow(children: <Widget>[SkillRow(skillInfo: skills[i])])
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
 
}