import 'package:flutter/material.dart';
import 'package:mentorApp/constants/navigation_constants.dart';
import 'package:mentorApp/constants/profile_constants.dart';
import './summary.dart';
import './education.dart';
import './experience.dart';
import './skills.dart';
import './contact.dart';

 
class ProfileSections extends StatelessWidget {  

  final Map data;
  ProfileSections({Key key, @required this.data}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return 
    Container(
      height: MediaQuery.of(context).size.height - kProfileHeaderHeight - kAppNavBarHeight,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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