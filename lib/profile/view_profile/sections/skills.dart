import 'package:flutter/material.dart';

import '../../../constants/profile_constants.dart';
import '../../../models/models.dart';
import '../../common/section.dart';
import '../../common/skill_row.dart';
 
class ProfileSkills extends StatelessWidget {  
  final List<Skill> skills;
  ProfileSkills({Key key, @required this.skills}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return skills.length > 0
      ? Section(
      title: sectionTitleSkills,
      child: buildSkillList()
      ) : SizedBox();
  }

  Widget buildSkillList() {
    var expertList = <Widget>[];
    var intermediateList = <Widget>[];
    var beginnerList = <Widget>[];

    // Temporary workaround for sorting skills
    for (var i = 0; i < skills.length; i++) {
      if (skills[i].level == skillExpert){
        expertList.add(
          SectionRow(children: <Widget>[SkillRow(skill: skills[i])]
          )
        );
      } else if (skills[i].level == skillIntermediate){
        intermediateList.add(
          SectionRow(children: <Widget>[SkillRow(skill: skills[i])])
        );
      } else if (skills[i].level == skillBeginner){
        beginnerList.add(
          SectionRow(children: <Widget>[SkillRow(skill: skills[i])])
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