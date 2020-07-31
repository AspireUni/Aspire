import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


import '../../common/common.dart';
import '../../constants/constants.dart';
import '../firebase_authentication.dart';
import '../login.dart';


class LinkSent extends StatefulWidget {
  final String emailAddress;
  final bool resetLinkSent;

  LinkSent({
    Key key, 
    @required this.emailAddress, 
    this.resetLinkSent = false
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LinkSent();
}

class _LinkSent extends State<LinkSent> {
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
        buildReminderSection(),
        buildFooter()
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
          Image.asset('images/sign_up/ano_hands_side.png', height: 100),
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
        initialValue: widget.emailAddress,
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

  Widget buildReminderSection() {
    return Positioned(
      top: screenHeight * 0.50,
      child: Column(
        children: <Widget>[
          buildLinkSentInfoBorder(),
          buildLinkSentInfoText()
        ]
      )
    );
  }

  Widget buildLinkSentInfoText() {
    return Container(
      padding: EdgeInsets.only(top: 15.0),
      child: FormatText(
        text: widget.resetLinkSent ? resetLinkSentInfoText : linkSentInfoText,
        textColor: Theme.of(context).primaryColor,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
    );
  }

  Widget buildLinkSentInfoBorder() {
    return InfoBorder(
      text: linkSentInfoBorder
    );
  }

  Widget buildFooter() {
    return Positioned(
      bottom: screenHeight * 0.05,
      child: Row(
        children: <Widget>[
          buildFooterText(),
          buildFooterLink()
        ]
      )
      );
  }

  Widget buildFooterText() {
    return FormatText(
      text: linkSentFooterText,
      textColor: Theme.of(context).primaryColor,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    );
  }

  Widget buildFooterLink() {
    return InkWell(
      onTap: () => Auth().sendEmailVerification(),
      child: FormatText(
        text: linkSentFooterLink,
        textColor: Theme.of(context).accentColor,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
    );
  }
}
