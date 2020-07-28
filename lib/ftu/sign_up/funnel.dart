import 'package:flutter/material.dart';

import '../../common/format_text.dart';
import '../../common/global_header.dart';
import '../../common/primary_button.dart';
import '../../constants/common_constants.dart';
import '../../constants/ftu_constants.dart';
import '../login_create_account/login.dart';

class SignUpFunnel extends StatelessWidget {
  
  SignUpFunnel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Replace with primaryColor when center ano image is updated
      backgroundColor: Color(0xFF0B0B33),
      body: Container(
        child: Stack(
          children: [ 
            buildHeader(context), 
            buildCenterAno(context), 
            buildFooter(context)
          ]
        )
      )
    );
  }

  getNextPage(context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login())
    );
  }

  GlobalHeader buildHeader(context) {
    return GlobalHeader(
        actionText: signInAction, 
        onActionTap: () => getNextPage(context), 
        isLight: true
      );
  }

  Widget buildCenterAno(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('images/sign_up/ano_hands_up.png', height: 150.0),
        Container(height: 1.5, color: Colors.white)
      ]
    );
  }

  // TODO: Make a common global_footer widget to maintain consistent padding
  Widget buildFooter(context) {
    var screenWidth = MediaQuery.of(context).size.width; 
    var screenHeight = MediaQuery.of(context).size.height; 
    var heightPadding = screenHeight * 0.08;
    var widthPadding = screenWidth * 0.21;

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
          buildFunnelText(), 
          buildCircleIndicators(context, screenWidth), 
          ...buildFunnelButtons()
        ]
      )
    );
  }

  Widget buildFunnelText() {
    return Padding(
      padding: EdgeInsets.only(bottom: 40.0),
      child: FormatText(
        text: funnelQuestionText,
        textColor: Colors.white,
        textAlign: TextAlign.center,
        fontSize: 14.0,
        fontWeight: FontWeight.w500
      )
    );
  }
  
  // TODO: Make a common circle_indicators widget is created
  Row buildCircleIndicators(context, screenWidth) {
    var circleDimensions = screenWidth * 0.01;
    var circles = <Widget>[];
    for (var i = 0; i < 3; i++) {
      circles.add(
        Container(
          width: circleDimensions, 
          height: circleDimensions, 
          margin: EdgeInsets.all(screenWidth * 0.02), 
          decoration: BoxDecoration(
            color: i == 0 ? 
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
  
  List<PrimaryButton> buildFunnelButtons() {
    var isLight = true;
    return [
      PrimaryButton(
        text: isMentorAction,
        isLight: isLight, 
        onPressed: () => { print("I am a mentor pressed.") }
      ), 
      PrimaryButton(
        text: isMenteeAction,
        isLight: isLight, 
        onPressed: () => { print("I am a mentee pressed.") }
      ), 
    ];
  }
  
}
