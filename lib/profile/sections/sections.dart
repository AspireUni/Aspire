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
  final Map<String, GlobalKey> keys;
  ProfileSections({Key key, @required this.data, @required this.keys}) : super(key: key);
  
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
              key: keys["bioKey"],
              summary: data["summary"]
            ),
            ProfileEducation(
              key: keys["educationKey"], 
              schools: data["schools"]
            ),
            ProfileExperience(
              key: keys["experienceKey"], 
              jobs: data["jobs"]
            ),
            ProfileSkills(
              key: keys["skillsKey"], 
              skills: data["skills"]
            ),
            ProfileContact(
              key: keys["contactKey"], 
              contact: data["contact"],
              fullName: data["fullName"]
            )
          ]
        )
      )
    );
  }
}