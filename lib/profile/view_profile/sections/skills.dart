import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../constants/profile_constants.dart';
import '../../../models/models.dart';
import '../../../selectors/selectors.dart';
import '../../common/section.dart';
import '../../common/skill_row.dart';
 
class ProfileSkills extends StatelessWidget {  
  ProfileSkills({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Skill>>(
      converter: skillListSelector,
      builder: (context, skills) => skills != null 
      ? Section(
      title: sectionTitleSkills,
      child: buildSkillList(skills)
      ) : SizedBox()
    );
  }

  Widget buildSkillList(List<Skill> skills) {
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