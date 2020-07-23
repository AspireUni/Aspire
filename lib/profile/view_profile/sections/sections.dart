import 'package:flutter/material.dart';
import './contact.dart';
import './education.dart';
import './experience.dart';
import './skills.dart';
import './summary.dart';

 
class ProfileSections extends StatelessWidget {  
  ProfileSections({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Flexible(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget> [
            ProfileSummary(),
            ProfileEducation(),
            ProfileExperience(),
            ProfileSkills(),
            ProfileContact()
          ]
        )
      )
    );
  }
}