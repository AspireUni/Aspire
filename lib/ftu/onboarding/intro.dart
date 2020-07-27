import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/format_text.dart';
import '../../common/primary_button.dart';
import '../../constants/common_constants.dart';
import '../../constants/ftu_constants.dart';
import './screens.dart';

class OnboardingIntro extends StatelessWidget {
  
  OnboardingIntro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: screenWidth,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: screenHeight * 0.15,
              child: buildTitle()
            ),
            Column(
              children: <Widget>[
                buildCenterLogo(screenHeight),
                buildBottomText(screenHeight)
              ]
            ),
            Positioned(
              bottom: screenHeight * 0.10,
              child: buildGetStartedButton(context)
            )
          ]
        )
      )
    );
  }

  Widget buildTitle() {
    return Column(
      children: <Widget>[
        FormatText(
          text: appName,
          textColor: Colors.white,
          fontSize: 50.0,
          fontWeight: FontWeight.w700,
        ),
        buildSubTitle()
      ]
    );
  }

  Widget buildSubTitle() {
    return  Container(
      padding: EdgeInsets.only(top: 5.0),
      child: FormatText(
        text: getStartedSubTitle,
        textColor: Colors.white,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
    );
  }

  Widget buildCenterLogo(double screenHeight) {
    return Container(
      padding: EdgeInsets.only(
        top: screenHeight * 0.40
      ),
      child: SvgPicture.asset(
        'images/light_logo.svg',
        height: screenHeight * 0.15,
        width: screenHeight * 0.15,
      )
    );
  }

  Widget buildBottomText(double screenHeight) {
    return Container(
      padding: EdgeInsets.only(
        top: screenHeight * 0.20
      ),
      child: FormatText(
        text: getStartedBottomText,
        textColor: Colors.white,
        textAlign: TextAlign.center,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
    );
  }

  Widget buildGetStartedButton(BuildContext context) {
    return PrimaryButton(
      text: getStartedButtonText,
      isLight: true,
      onPressed: () => Navigator.pushReplacement(
        context, MaterialPageRoute(
          builder: (context) => OnboardingScreens(screenNum: 0)
        )
      )
    );
  }
}
