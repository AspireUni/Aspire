import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/profile_constants.dart';

class AppBarWithSave extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<FormBuilderState> formKey;
  final String appBarTitle;
  final Map<String, Object> data;
  AppBarWithSave({Key key, @required this.appBarTitle, @required this.formKey, this.data}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: closeAction(context),
      actions: <Widget>[saveAction(formKey)],
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      title: buildAppBarTitle(editProfile)
    );
  }

  Widget saveAction(GlobalKey<FormBuilderState> key) {
    return Container(
      padding: EdgeInsets.only(
        top: 17.0,
        right: 20.0
      ),
      child: InkWell(
        onTap: () {
          if (key.currentState.saveAndValidate()) {
            print(data);
            print(key.currentState.value);
          } else {
            print("Validation failed.");
          }
        },
        child: Text(
          save,
          style: GoogleFonts.muli(
            textStyle: TextStyle(
              color: Colors.white, 
              letterSpacing: .5, 
              fontSize: 15.0, 
              fontWeight: FontWeight.bold
            )
          )
        )
      )
    );
  }

  Widget closeAction(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.close,
        color: Colors.white
      )
    );
  }

  Widget buildAppBarTitle(String titleText) {
    return Text(
      titleText,
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.white, 
          letterSpacing: .5, 
          fontSize: 20.0, 
          fontWeight: FontWeight.bold
        )
      )
    );
  }
}
