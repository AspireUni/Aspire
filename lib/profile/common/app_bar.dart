import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/profile_constants.dart';

class AppBarWithSave extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<FormBuilderState> formKey;
  final String appBarTitle;
  final void Function() onSaveActionTap;
  final void Function() onCloseActionTap;
  final bool closeActionEnabled;

  final FocusNode saveFocus = FocusNode();
  final FocusNode closeFocus = FocusNode();

  AppBarWithSave({
    Key key,
    @required this.appBarTitle,
    @required this.formKey,
    @required this.closeActionEnabled,
    this.onSaveActionTap,
    this.onCloseActionTap,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: closeActionEnabled ? closeAction(context) : null,
      actions: <Widget>[saveAction(formKey)],
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      title: buildAppBarTitle()
    );
  }

  Widget saveAction(GlobalKey<FormBuilderState> key) {
    return Container(
      padding: EdgeInsets.only(
        top: 17.0,
        right: 20.0
      ),
      child: InkWell(
        focusNode: saveFocus,
        onTap: () {
          getFocus(saveFocus);
          if (key.currentState.saveAndValidate()) {
            onSaveActionTap();
          } else {
            print("Validation failed.");
          }
          saveFocus.unfocus();
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
      focusNode: closeFocus,
      onPressed: () {
        onCloseActionTap();
        getFocus(closeFocus);
        Navigator.pop(context);
        closeFocus.unfocus();
      },
      icon: Icon(
        Icons.close,
        color: Colors.white
      )
    );
  }

  Widget buildAppBarTitle() {
    return Text(
      appBarTitle,
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

  void getFocus(FocusNode focus){
    if (!focus.hasFocus) {
      focus.requestFocus();
    }
  }

}
