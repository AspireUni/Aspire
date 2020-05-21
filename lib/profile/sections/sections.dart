import 'package:flutter/material.dart';
import '../section_icons.dart';
import './skills.dart';
import './bio.dart';
import './info.dart';

 
class ProfileSections extends StatefulWidget {  

  final Map data;
  ProfileSections({Key key, @required this.data}) : super(key: key);
  
  @override
  ProfileSectionsState createState() => ProfileSectionsState();
 
}
  
class ProfileSectionsState extends State<ProfileSections> {

  String activeSection = "Skills";

  buildSection() {
    switch (activeSection) {
      case "Skills":
        return ProfileSkills(skills: widget.data["skills"]);
      case "Bio":
        return ProfileBio(bio: widget.data["bio"]);
      case "Info":
        return ProfileInfo(info: widget.data["info"]);
    }
  }

  void _handlePress(String section) {
    setState(() {
      activeSection = section;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget> [
        Container(
          padding: EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 20.0),
          height: MediaQuery.of(context).size.height * 0.45,
          child: buildSection()
        ),
        ProfileSectionIcons(
          activeSection: activeSection, 
          handlePress: _handlePress
        )
      ]
    );
  }
}