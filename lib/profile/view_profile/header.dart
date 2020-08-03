import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/common.dart';
import '../../constants/profile_constants.dart';
import '../save_profile/save_profile.dart';
 
class ProfileHeader extends StatelessWidget {
  final String fullName;
  final bool viewOnly;

  ProfileHeader(
    {Key key, @required this.fullName, @required this.viewOnly}
  ) : super(key: key);

  final GlobalKey<FormBuilderState> _editProfileKey
    = GlobalKey<FormBuilderState>();
  
  @override
  Widget build(BuildContext context) {
    CommonContext().init(context);

    return Container(
      width: ScreenSize.width, 
      height: profileHeaderHeight,
      decoration: BoxDecoration(
        color: ThemeColors.primary, 
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40.0)
        ),
      ),
      child: Stack(
        children: <Widget> [
          Positioned(
            top: 40.0,
            left: 0,
            width: ScreenSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                buildProfilePhoto(context),
                buildFullName(context),
              ]
            )
          ),
          if (viewOnly) Positioned(
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
        color: ThemeColors.accent, 
        shape: BoxShape.circle
      )
    );
  }

  buildFullName(context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Text> [
          Text(
            fullName,
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
    return InkWell(
      onTap: () => handleEditTap(context),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Icon(
          headerEditIconData,
          color: Colors.white,
          size: 30.0,
        )
      ),
    );
  }

  handleEditTap(BuildContext context) async {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => 
        SaveProfile(
          editMode: true,
          formKey: _editProfileKey,
        )
      )
    );
  }
}