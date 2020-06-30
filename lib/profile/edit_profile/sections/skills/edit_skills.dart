import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/profile_constants.dart';
import '../../../view_profile/sections/section.dart';
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
          buildAddSkillRow(),
          buildSkillList(context)
        ]
      )
    );
  }

  buildAddSkillRow() {
    IconData add = IconData(
      0xf2c7,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage
    );
    return InkWell(
      onTap: () => handleAddTap(context),
      child: SectionRow(
        children: <Widget>[
          Row(
            children: <Widget> [
              Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  add,
                  color: Colors.black54,
                  size: 20.0,
                )
              ),
              Text(
                "Add a skill...",
                textAlign: TextAlign.left,
                style: GoogleFonts.muli(
                  textStyle: TextStyle(
                    color: Colors.black54,
                    letterSpacing: .5,
                    height: 1.3,
                    fontSize: 15.0,
                  ),
                )
              )
            ]
          )
        ]
      )
    );
  }

  buildSkillRow(BuildContext context, Map<String, Object> skillInfo) {
    final IconData edit = IconData(
      0xf2bf,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage
    );
    return InkWell(
      onTap: () => handleEditTap(context, skillInfo),
      child: SectionRow(
        children: <Widget>[
          Row(
            children: <Widget> [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildSkillText(skillInfo['skill'], isSkill: true),
                    buildSkillText(skillInfo['level'], isSkill: false)
                  ]
                )
              ),
              Container(
                padding: EdgeInsets.only(right: 5.0, left: 10.0),
                child: Icon(
                  edit,
                  color: Colors.black54,
                  size: 20.0,
                )
              ),
            ]
          )
        ]
      )
    );
  }

  buildSkillList(BuildContext context) {
    List<Widget> expertList = [];
    List<Widget> intermediateList = [];
    List<Widget> beginnerList = [];

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

  handleAddTap(BuildContext context) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SaveSkill(
          editMode: false
        )
      )
    );
  }

  handleEditTap(BuildContext context, Map<String, Object> skillInfo) {
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
