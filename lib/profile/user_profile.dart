import 'package:flutter/material.dart';
import './header.dart';
import './sections/sections.dart';

 
// TODO: Replace with real data
Map dummyData = {
  "fullName": "John Doe",
  "emailAddress": "johndoe@ualberta.ca",
  "bio": """Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.""",
  "info": "Info goes here",
  "skills": "Skills go here"
};
 
class UserProfile extends StatelessWidget {
 const UserProfile({Key key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        //TODO: Add background
        /* Image.asset(
          "images/DefaultBg.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.fill,
        ), */
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: const EdgeInsets.all(0),
            child: Center(
              child: Column(
                children: buildUserProfileView()
              )
            )
          )
        )
      ]
    );
  }
}
 
buildUserProfileView() {
 return (
   <Widget>[
     ProfileHeader(
      fullName: dummyData["fullName"], 
      emailAddress: dummyData["emailAddress"],
      ),
     ProfileSections(data: dummyData),
   ]
 );
}