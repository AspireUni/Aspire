import 'package:flutter/material.dart';

import '../../common/global_header.dart';
import '../../constants/ftu_constants.dart';
import 'footer.dart';

class OnboardingScreens extends StatelessWidget {
  final screenNum;

  OnboardingScreens({Key key, @required this.screenNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: [
            GlobalHeader(), 
            buildCenterAno(context, screenHeight),
            OnboardingFooter(screenNum: screenNum)
          ]
        )
      )
    );
  }

  Widget buildCenterAno(context, screenHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        onboardingScreensConfig[screenNum]["image"],
        Container(height: 1.5, color: Colors.black)
      ]
    );
  }
  
}
