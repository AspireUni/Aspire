import 'package:flutter/material.dart';

import '../../common/format_text.dart';
import '../../common/primary_button.dart';
import '../../constants/common_constants.dart';
import '../../constants/ftu_constants.dart';
import '../login_create_account/login_create_account.dart';
import './screens.dart';

var onboardingScreensConfig = [
  {
    "text": onboardingPartOneText,
    "nextScreen": (context) => OnboardingScreens(screenNum: 1), 
    "buttonText": nextButtonText, 
    "isLight": true
  },
  {
    "text": onboardingPartTwoText, 
    "nextScreen": (context) => OnboardingScreens(screenNum: 2),
    "buttonText": nextButtonText, 
    "isLight": true
  }, 
  {
    "text": onboardingPartThreeText, 
    "nextScreen": (context) => LoginCreateAccount(), 
    "buttonText": letsGetStartedButtonText, 
    "isLight": false
  }
];

class OnboardingFooter extends StatelessWidget {
  final int screenNum;

  OnboardingFooter({Key key, @required this.screenNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var widthPadding = screenWidth * 0.24;
    var heightPadding = screenHeight * 0.10;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        widthPadding, 
        heightPadding, 
        widthPadding, 
        heightPadding
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildOnboardingText(), 
          buildCircleIndicators(context, screenWidth, screenNum), 
          buildOnboardingButton(context, screenNum)
        ]
      )
    );
  }

  void getNextPage(context, screenNum) {
    var nextScreen = onboardingScreensConfig[screenNum]["nextScreen"];
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: nextScreen)
    );
  }

  Widget buildOnboardingText() {
    return Padding(
      padding: EdgeInsets.only(bottom: 60.0),
      child: FormatText(
        text: onboardingScreensConfig[screenNum]["text"],
        textColor: Colors.black,
        textAlign: TextAlign.center,
        fontSize: 14.0,
        fontWeight: FontWeight.w500
      )
    );
  }

  Row buildCircleIndicators(context, screenWidth, screenNum) {
    var circleDimensions = screenWidth * 0.01;
    var circles = <Widget>[];
    for (var i = 0; i < 3; i++) {
      circles.add(
        Container(
          width: circleDimensions, 
          height: circleDimensions, 
          margin: EdgeInsets.all(screenWidth * 0.02), 
          decoration: BoxDecoration(
            color: i == screenNum ? 
              Theme.of(context).accentColor : Colors.grey, 
            shape: BoxShape.circle
          )
        )
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: circles
    ); 
    
  }

  Widget buildOnboardingButton(context, partNum) {
    return PrimaryButton(
      text: onboardingScreensConfig[screenNum]["buttonText"],
      isLight: onboardingScreensConfig[screenNum]["isLight"],
      onPressed: () => getNextPage(context, partNum)
    );
  }
}