import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/format_text.dart';
import '../../common/primary_button.dart';
import '../../constants/common_constants.dart';
import '../../constants/ftu_constants.dart';
import '../signuplogin.dart';

class GetStartedIntro extends StatelessWidget {
  
  GetStartedIntro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            buildTitle(context),
            buildSubTitle(),
            buildCenterLogo(context),
            buildBottomText(context),
            buildGetStartedButton(context)
          ]
        )
      )
    );
  }

  Widget buildTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.width * 0.30
      ),
      child: FormatText(
        text: appName,
        textColor: Colors.white,
        fontSize: 50.0,
        fontWeight: FontWeight.w700,
      )
    );
  }

  Widget buildSubTitle() {
    return  Container(
      padding: EdgeInsets.only(top: 5.0),
      child: FormatText(
        text: getStartedSubTitle,
        textColor: Colors.white,
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
      )
    );
  }

  Widget buildCenterLogo(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.width * 0.30
      ),
      child: SvgPicture.asset(
        'images/light_logo.svg',
        height: 200.0,
        width: 200.0,
      )
    );
  }

  Widget buildBottomText(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.width * 0.30
      ),
      child: FormatText(
        text: getStartedBottomText,
        textColor: Colors.white,
        textAlign: TextAlign.center,
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
      )
    );
  }

  Widget buildGetStartedButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: PrimaryButton(
        text: getStartedButtonText,
        onPressed: () => Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (context) => LoginSignupPage()
          )
        )
      )
    );
  }
}
