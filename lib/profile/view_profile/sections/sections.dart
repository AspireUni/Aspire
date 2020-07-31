import 'package:flutter/material.dart';

import '../../../models/models.dart';
import './contact.dart';
import './education.dart';
import './experience.dart';
import './skills.dart';
import './summary.dart';

 
class ProfileSections extends StatelessWidget {
  final User user;
  final String matchId;
  final String id;
  final bool isOwnProfile;

  ProfileSections(
    {Key key, @required this.user, this.id, this.matchId, this.isOwnProfile}
  ) : super(key: key);
  
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
            ProfileContact(
              user: user, isOwnProfile: isOwnProfile, id: id, matchId: matchId
            )
          ]
        )
      )
    );
  }
}