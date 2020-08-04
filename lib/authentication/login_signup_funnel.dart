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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: ScreenSize.width,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
             Positioned(
              top: ScreenSize.height * 0.15,
              child: buildTitle(context)
            ),
            Column(
              children: <Widget>[
                buildCenterLogo(),
                buildLoginButton(context),
                buildCreateAccountButton(context),
              ]
            ),
            Positioned(
              bottom: ScreenSize.height * 0.05,
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
          textColor: ThemeColors.primary,
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
        textColor: ThemeColors.primary,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
    );
  }

  // TODO: Change when mockup svgs are available
  Widget buildCenterLogo() {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenSize.height * 0.40
      ),
      child: SvgPicture.asset(
        'images/dark_logo.svg',
        height: ScreenSize.height * 0.15,
        width: ScreenSize.height * 0.15,
      )
    );
  }

  Widget buildLoginButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenSize.height * 0.20
      ),
      child: PrimaryButton(
        text: loginButtonText,
        isLight: false,
        onPressed: () => Navigator.push(
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
        onPressed: () => Navigator.push(
          context, MaterialPageRoute(
            builder: (context) => SignUpFunnel()
          )
        )
      )
    );
  }

}
