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
    var expertList = <Widget>[];
    var intermediateList = <Widget>[];
    var beginnerList = <Widget>[];

    // Temporary workaround for sorting skills
    for (var i = 0; i < skills.length; i++) {
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

    var skillList = [
      ...expertList, 
      ...intermediateList, 
      ...beginnerList
    ];

    return SectionList(children: skillList);
  }
 
}