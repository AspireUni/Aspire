import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../common/common.dart';
import '../../constants/constants.dart';
import '../login.dart';


class ResetLink extends StatefulWidget {

  ResetLink({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ResetLink();
}

class _ResetLink extends State<ResetLink> {
  final GlobalKey<FormBuilderState> _disabledEmailAddressFormKey
    = GlobalKey<FormBuilderState>();

  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GlobalHeader(
        actionText: signInAction,
        onActionTap: () => Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (context) => Login()
          )
        )
      ),
      body: buildLinkSentView()
    );
  }

  Widget buildLinkSentView() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: screenHeight * 0.15,
          child: buildCenterAno()
        ),
        Positioned(
          top: screenHeight * 0.35,
          child: buildForm()
        ), 
        Positioned(
          top: screenHeight * 0.50,
          child: buildLoginButton()
        )
      ]
    );
  }

  Widget buildForm() {
    return Container(
      width: screenWidth * 0.60,
      child: FormBuilder(
        key: _disabledEmailAddressFormKey,
        child: Column(
          children: <Widget>[
            buildEmailAddressField(),
          ]
        )
      )
    );
  }

  Widget buildCenterAno() {
    return Container(
      width: screenWidth,
      child: Column(
        children: <Widget>[
          Image.asset('images/sign_up/ano_hands_straight_up.png', height: 100.0),
          Container(
            height: 1.5,
            color: Colors.black
          )
        ]
      )
    );
  }

  Widget buildEmailAddressField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FormBuilderTextField(
        enabled: false,
        readOnly: true,
        attribute: 'emailAddress',
        style: fieldTextStyle(color: Colors.grey),
        decoration: fieldDecoration(
          context,
          isFocused: false,
          isInvalid: false,
          hintText: emailHint,
          icon: Icons.mail_outline
        )
      )
    );
  }
  
  Widget buildLoginButton() {
    return PrimaryButton(
        isLight: true,
        text: getResetLinkText,
        onPressed: () => print("Pressed get reset link.")
    );
  }

}
