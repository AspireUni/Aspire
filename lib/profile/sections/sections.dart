import 'package:flutter/material.dart';
import './contact.dart';
import './education.dart';
import './experience.dart';
import './skills.dart';
import './summary.dart';

 
class ProfileSections extends StatelessWidget {  

  final Map data;
  ProfileSections({Key key, @required this.data}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return 
    Container(
      child: Flexible(
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget> [
            ProfileSummary(
              summary: data["summary"]
            ),
            ProfileEducation(
              schools: data["schools"]
            ),
            ProfileExperience(
              jobs: data["jobs"]
            ),
            ProfileSkills(
              skills: data["skills"]
            ),
            ProfileContact(
              contact: data["contact"],
              fullName: data["fullName"]
            )
          ]
        )
      )
    );
  }
}