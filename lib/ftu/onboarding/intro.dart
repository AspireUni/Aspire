import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/common.dart';
import '../../common/common_context.dart';
import '../../constants/constants.dart';
import './steps.dart';

class OnboardingIntro extends StatelessWidget {
  
  OnboardingIntro({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommonContext().init(context);
  
    return Scaffold(
      backgroundColor: ThemeColors.primaryColor,
      body: Container(
        width: ScreenSize.screenWidth,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: ScreenSize.screenHeight * 0.15,
              child: buildTitle()
            ),
            Column(
              children: <Widget>[
                buildCenterLogo(),
                buildBottomText()
              ]
            ),
            Positioned(
              bottom: ScreenSize.screenHeight * 0.10,
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

  Widget buildCenterLogo() {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenSize.screenHeight * 0.40
      ),
      child: SvgPicture.asset(
        'images/light_logo.svg',
        height: ScreenSize.screenHeight * 0.15,
        width: ScreenSize.screenHeight * 0.15,
      )
    );
  }

  Widget buildBottomText() {
    return Container(
      width: ScreenSize.screenWidth * 0.60,
      padding: EdgeInsets.only(
        top: ScreenSize.screenHeight * 0.20
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
          builder: (context) => OnboardingSteps()
        )
      )
    );
  }
}
