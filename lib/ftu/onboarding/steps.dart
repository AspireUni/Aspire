import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

import '../../authentication/login_signup_funnel.dart';
import '../../common/common.dart';
import '../../constants/common_constants.dart';
import '../../constants/ftu_constants.dart';

class OnboardingSteps extends StatefulWidget {
 
  OnboardingSteps({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OnboardingSteps();
}

class _OnboardingSteps extends State<OnboardingSteps> {

  int stepIndex;

  @override
  void initState() {
    super.initState();

    stepIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    CommonContext().init(context);
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildHeader(),
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [ 
            buildContent(),
            buildFooter()
          ]
        )
      )
    );
  }

  GlobalHeader buildHeader() {
    var isLastStep = stepIndex == onboardingStepsConfig.length - 1;
    return isLastStep 
      ? GlobalHeader()
      : GlobalHeader(
        actionText: skipAction, 
        onActionTap: getSkipPage
      );
  }

  void getSkipPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginSignupFunnel())
    );
  }

  Widget buildContent() {
    return Column(
      children:[
        buildCenterAno(),
        Container(height: 1.5, color: Colors.black),
        buildOnboardingText()
      ]
    );
  }

  Widget buildCenterAno() {
    return Padding(
      padding: EdgeInsets.only(top: ScreenSize.screenHeight * 0.30),
      child: SlideInRight(
        key: onboardingStepsConfig[stepIndex]["imageKey"],
        child: Image.asset(
          onboardingStepsConfig[stepIndex]["image"],
          height: ScreenSize.screenHeight * 0.15
        ),
      )
    );
  }

  Widget buildOnboardingText() {
    return SlideInRight(
      key: onboardingStepsConfig[stepIndex]["textKey"],
      child: Container(
        padding: EdgeInsets.only(top: ScreenSize.screenHeight * 0.15),
        width: ScreenSize.screenWidth * 0.60,
        child: FormatText(
          text: onboardingStepsConfig[stepIndex]["text"],
          textColor: Colors.black,
          textAlign: TextAlign.center,
          fontSize: 14.0,
          fontWeight: FontWeight.w500
        )
      )
    );
  }

  Widget buildFooter() {
    return Positioned(
      bottom: ScreenSize.screenHeight * 0.10,
      child: Column(
        children: <Widget>[
          CircleIndicators(stepIndex: stepIndex),
          buildOnboardingButton()
        ]
      )
    );
  }

  Widget buildOnboardingButton() {
    return PrimaryButton(
      text: onboardingStepsConfig[stepIndex]["buttonText"],
      isLight: onboardingStepsConfig[stepIndex]["isLight"],
      onPressed: getNextStep
    );
  }

  void getNextStep() {
    if (stepIndex < 2) {
      setState(() { stepIndex += 1; });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginSignupFunnel())
      );
    }
  }
}
