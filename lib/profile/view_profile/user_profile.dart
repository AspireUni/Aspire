import 'package:flutter/material.dart';
import './header.dart';
import './sections/sections.dart';
 
class UserProfile extends StatelessWidget {
  const UserProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.all(0),
        child: Center(
          child: Column(
            children: buildUserProfileView()
          )
        )
      )
    );
  }

  buildUserProfileView() {
    return (
      <Widget>[
        ProfileHeader(),
        ProfileSections()
      ]
    );
  }

}
