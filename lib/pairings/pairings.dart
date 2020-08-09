import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

import '../common/common.dart';
import './cards.dart';

class Pairings extends StatelessWidget {
  final GlobalKey<InOutAnimationState> upDownAnimationAno = 
    GlobalKey<InOutAnimationState>();
  
  Pairings({Key key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalHeader(),
      backgroundColor: Colors.white,
      body: buildPairings()
    );
  }

  Stack buildPairings() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: ScreenSize.height * 0.04, 
          child: Cards()
        ),
        Positioned(
          bottom: 0, 
          child: buildAnoAnimation()
        )
      ]
    );
  }

  InOutAnimation buildAnoAnimation() {
      return InOutAnimation(
        key: upDownAnimationAno,
        inDefinition: SlideInUpAnimation(),
        outDefinition: SlideOutDownAnimation(),
        child: buildAno()
      );
    }

  Image buildAno() {
    return Image.asset(
      'images/ano_mountains.png',
      height: ScreenSize.height * 0.25
    );
  }

}