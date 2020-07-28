import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../../constants/profile_constants.dart';
import '../../../../models/models.dart';
import '../../../../selectors/selectors.dart';
import '../../../common/add_row_button.dart';
import '../../../common/section.dart';
import '../../../common/skill_row.dart';
import '../../../common/styles.dart';
import 'skill_item.dart';

class SaveSkills extends StatefulWidget {
  SaveSkills({Key key}) : super(key: key);

  @override
  _SaveSkillsState createState() => _SaveSkillsState();
}

class _SaveSkillsState extends State<SaveSkills> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          AddRowButton(
            text: addSkillRowText,
            onTap: handleAddTap
          ),
          StoreConnector<AppState, List<Skill>>(
            converter: skillListSelector,
            builder: (context, skills) => skills != null 
            ? buildSkillList(skills) : SizedBox()
          )
        ]
      )
    );
  }

  Widget buildSkillRow(Skill skill) {
    return InkWell(
      onTap: () => handleEditTap(skill.id),
      child: SectionRow(
        children: <Widget>[
          SkillRow(skill: skill),
          editButtonInRow
        ]
      )
    );
  }

  Widget buildSkillList(List<Skill> skills) {
    var expertList = <Widget>[];
    var intermediateList = <Widget>[];
    var beginnerList = <Widget>[];

    // Temporary workaround for sorting skills
    for (var i = 0; i < skills.length; i++) {
      if (skills[i].level == skillExpert){
        expertList.add(buildSkillRow(skills[i]));
      } else if (skills[i].level == skillIntermediate){
        intermediateList.add(buildSkillRow(skills[i]));
      } else if (skills[i].level == skillBeginner){
        beginnerList.add(buildSkillRow(skills[i]));
      }
    }
    
    var skillList = [
      ...expertList, 
      ...intermediateList, 
      ...beginnerList
    ];

    return SectionList(children: skillList);
  }

  void handleAddTap() {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SaveSkillItem(
          editMode: false
        )
      )
    );
  }

  void handleEditTap(String skillId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SaveSkillItem(
          editMode: true,
          skillId: skillId
        )
      )
    );
  }

}
