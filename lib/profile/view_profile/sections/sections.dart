import 'package:flutter/material.dart';

import '../../../models/models.dart';
import './contact.dart';
import './education.dart';
import './experience.dart';
import './skills.dart';
import './summary.dart';

 
class ProfileSections extends StatelessWidget {
  final User user;

  ProfileSections({Key key, @required this.user}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return Container(
      child: Flexible(
        child: ListView(
          padding: EdgeInsets.all(0.0),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget> [
            ProfileSummary(summary: user.summary),
            ProfileEducation(schools: user.schools),
            ProfileExperience(jobs: user.jobs),
            ProfileSkills(skills: user.skills),
            ProfileContact(user: user)
          ]
        )
      )
    );
  }
}