import 'package:flutter/material.dart';

import '../../common/global_header.dart';
import '../../constants/common_constants.dart';
import '../../constants/ftu_constants.dart';
import '../../ftu/login_create_account/login_create_account.dart';
import './footer.dart';

class OnboardingScreens extends StatelessWidget {
  final screenNum;

  OnboardingScreens({Key key, @required this.screenNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [ 
            buildHeader(context), 
            buildCenterAno(context, screenWidth),
            OnboardingFooter(screenNum: screenNum)
          ]
        )
      )
    );
  }

  getSkipPage(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginCreateAccount())
    );
  }

  GlobalHeader buildHeader(context) {
    var isLastScreen = screenNum == onboardingScreensConfig.length - 1;
    return isLastScreen 
      ? GlobalHeader()
      : GlobalHeader(
        actionText: skipAction, 
        onActionTap: () => { getSkipPage(context) }
      );
  }

  Widget buildCenterAno(context, screenWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        onboardingScreensConfig[screenNum]["image"],
        Container(height: 1.5, color: Colors.black)
      ]
    );
  }
  
}
