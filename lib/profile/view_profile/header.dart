import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../actions/actions.dart';
import '../../constants/profile_constants.dart';
import '../../models/models.dart';
import '../../selectors/selectors.dart';
import '../../services/services.dart';
import '../save_profile/save_profile.dart';
 
class ProfileHeader extends StatelessWidget {
  final User user;

  ProfileHeader({Key key, @required this.user}) : super(key: key);

  final GlobalKey<FormBuilderState> _editProfileKey
    = GlobalKey<FormBuilderState>();
  
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
                buildFullName(context),
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

  buildFullName(context) {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Text> [
          Text(
            user.fullName,
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

  handleEditTap(BuildContext context) async {
    var store = StoreProvider.of<AppState>(context);
    var uid = userIdSelector(store);
    var userData = await getUser(uid);
    store.dispatch(ConvertToSaveProfileState(userData));
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