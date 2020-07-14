import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/profile_constants.dart';
import '../edit_profile/edit_profile.dart';
 
class ProfileHeader extends StatelessWidget {  
  final Map data;
  ProfileHeader({Key key, @required this.data}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width, 
      height: profileHeaderHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor, 
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0)
        ),
      ),
      child: Stack(
        children: <Widget> [
          Positioned(
            top: 40.0,
            left: 0,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                buildProfilePhoto(context),
                buildFullName(),
              ]
            )
          ),
          Positioned(
            top: 20.0,
            right: 0,
            child: buildEditButton(context)
          )
        ],
      )
    );
  }

  buildProfilePhoto(BuildContext context) {
    return Container(
      width: 60.0, 
      height: 60.0, 
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor, 
        shape: BoxShape.circle
      )
    );
  }

  buildFullName() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Text> [
          Text(
            data["fullName"],
            style: GoogleFonts.muli(
              textStyle: TextStyle(
                color: Colors.white, 
                letterSpacing: .5, 
                fontSize: 20.0, 
                fontWeight: FontWeight.bold
              ), 
            )
          )
        ]
      )
    );
  }

  buildEditButton(BuildContext context){
    var edit = IconData(
      headerEditIconCodePoint,
      fontFamily: CupertinoIcons.iconFont,
      fontPackage: CupertinoIcons.iconFontPackage
    );
    return InkWell(
      onTap: () => handleEditTap(context),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Icon(
          edit,
          color: Colors.white,
          size: 30.0,
        )
      ),
    );
  }

  handleEditTap(BuildContext context) {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => EditProfile(data: data))
    );
  }
}