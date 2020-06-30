import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/profile_constants.dart';
import '../../../common/add_row_button.dart';
import '../../../common/section.dart';
import '../../../common/skill_row.dart';
import '../../../common/styles.dart';
import './save_skill.dart';

class EditSkills extends StatefulWidget {
  final List<Map<String, Object>> skills;
  EditSkills({Key key, @required this.skills}) : super(key: key);

  @override
  _EditSkillsState createState() => _EditSkillsState();
}

class _EditSkillsState extends State<EditSkills> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          AddRowButton(
            text: addSkillRowText,
            onTap: () => handleAddTap(context)
          ),
          buildSkillList(context)
        ]
      )
    );
  }

  Widget buildSkillRow(BuildContext context, Map<String, Object> skillInfo) {
    return InkWell(
      onTap: () => handleEditTap(context, skillInfo),
      child: SectionRow(
        children: <Widget>[
          SkillRow(skillInfo: skillInfo),
          editButtonInRow,
        ]
      )
    );
  }

  Widget buildSkillList(BuildContext context) {
    List<Widget> expertList = [];
    List<Widget> intermediateList = [];
    List<Widget> beginnerList = [];

    // Temporary workaround for sorting skills
    for (int i = 0; i < widget.skills.length; i++) {
      if (widget.skills[i]["level"] == skillExpert){
        expertList.add(
          buildSkillRow(
            context, 
            widget.skills[i]
          )
        );
      } else if (widget.skills[i]["level"] == skillIntermediate){
        intermediateList.add(
          buildSkillRow(
            context, 
            widget.skills[i]
          )
        );
      } else if (widget.skills[i]["level"] == skillBeginner){
        beginnerList.add(
          buildSkillRow(
            context, 
            widget.skills[i]
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

  void handleAddTap(BuildContext context) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SaveSkill(
          editMode: false
        )
      )
    );
  }

  void handleEditTap(BuildContext context, Map<String, Object> skillInfo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SaveSkill(
          editMode: true,
          skillInfo: skillInfo
        )
      )
    );
  }

}
