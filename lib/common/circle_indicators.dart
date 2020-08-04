import 'package:flutter/material.dart';

import './common_context.dart';

class CircleIndicators extends StatelessWidget {
  final int stepIndex;
  
  CircleIndicators({Key key, @required this.stepIndex }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buildCircles(context)
    );
  }

  List<Widget> buildCircles(BuildContext context) {
    var screenWidth = ScreenSize.width;
    var circleDimensions = screenWidth * 0.01;
    var circles = <Widget>[];
    
    for (var i = 0; i < 3; i++) {
      circles.add(
        Container(
          width: circleDimensions, 
          height: circleDimensions, 
          margin: EdgeInsets.all(screenWidth * 0.02), 
          decoration: BoxDecoration(
            color: i == stepIndex ? 
              ThemeColors.accent : Colors.grey, 
            shape: BoxShape.circle
          )
        )
      );
    }
    return circles;
  }
}
