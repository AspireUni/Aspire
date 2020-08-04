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

  final GlobalKey<InOutAnimationState> inOutAnimationText = 
    GlobalKey<InOutAnimationState>();
  final GlobalKey<InOutAnimationState> inOutAnimationAno = 
    GlobalKey<InOutAnimationState>();

  @override
  void initState() {
    super.initState();

    stepIndex = 0;
  }

  @override
  Widget build(BuildContext context) {    
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
      padding: EdgeInsets.only(top: ScreenSize.height * 0.30),
      child: InOutAnimation(
        key: inOutAnimationAno,
        inDefinition: SlideInRightAnimation(),
        outDefinition: SlideOutLeftAnimation(),
        child: Image.asset(
          onboardingStepsConfig[stepIndex]["image"],
          height: ScreenSize.height * 0.15
        ),
      )
    );
  }

  Widget buildOnboardingText() {
    return InOutAnimation(
      key: inOutAnimationText,
      inDefinition: SlideInRightAnimation(),
      outDefinition: SlideOutLeftAnimation(),
      child: Container(
        padding: EdgeInsets.only(top: ScreenSize.height * 0.15),
        width: ScreenSize.width * 0.60,
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
      bottom: ScreenSize.height * 0.10,
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

  void getNextStep() async {
    if (stepIndex < 2 && 
      inOutAnimationText.currentState.status != InOutAnimationStatus.Out
    ) {
      inOutAnimationText.currentState.animateOut();
      inOutAnimationAno.currentState.animateOut();
      await Future.delayed(Duration(milliseconds: 400));
      setState(() { stepIndex += 1; });
      inOutAnimationText.currentState.animateIn();
      inOutAnimationAno.currentState.animateIn();
    } else if (stepIndex >= 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginSignupFunnel())
      );
    }
  }
}
