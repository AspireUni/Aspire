import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../common/common.dart';
import '../constants/constants.dart';
import './login.dart';
import './sign_up/funnel.dart';

class LoginSignupFunnel extends StatelessWidget {
  
  LoginSignupFunnel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: screenWidth,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
             Positioned(
              top: screenHeight * 0.15,
              child: buildTitle(context)
            ),
            Column(
              children: <Widget>[
                buildCenterLogo(screenHeight),
                buildLoginButton(context, screenHeight),
                buildCreateAccountButton(context),
              ]
            ),
            Positioned(
              bottom: screenHeight * 0.05,
              child: FooterLinks()
            )
          ]
        )
      )
    );
  }

  Widget buildTitle(BuildContext context) {
    return Column(
      children: <Widget>[
        FormatText(
          text: appName,
          textColor: Theme.of(context).primaryColor,
          fontSize: 50.0,
          fontWeight: FontWeight.w700,
        ),
        buildSubTitle(context)
      ]
    );
  }

  Widget buildSubTitle(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(top: 5.0),
      child: FormatText(
        text: getStartedSubTitle,
        textColor: Theme.of(context).primaryColor,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
    );
  }

  // TODO: Change when mockup svgs are available
  Widget buildCenterLogo(double screenHeight) {
    return Container(
      padding: EdgeInsets.only(
        top: screenHeight * 0.40
      ),
      child: SvgPicture.asset(
        'images/dark_logo.svg',
        height: screenHeight * 0.15,
        width: screenHeight * 0.15,
      )
    );
  }

  Widget buildLoginButton(BuildContext context, double screenHeight) {
    return Container(
      padding: EdgeInsets.only(
        top: screenHeight * 0.20
      ),
      child: PrimaryButton(
        text: loginButtonText,
        isLight: false,
        onPressed: () => Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (context) => Login()
          )
        )
      )
    );
  }
  Widget buildCreateAccountButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      child: PrimaryButton(
        text: createAccountButtonText,
        isLight: true,
        onPressed: () => Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (context) => SignUpFunnel()
          )
        )
      )
    );
  }

}
