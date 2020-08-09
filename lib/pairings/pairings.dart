import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

import '../common/common.dart';
import './cards.dart';

class Pairings extends StatefulWidget {
  const Pairings({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Pairings();
}

class _Pairings extends State<Pairings> {
  int matchIndex;
  final GlobalKey<InOutAnimationState> inOutAnimationCard = 
    GlobalKey<InOutAnimationState>();
  final GlobalKey<InOutAnimationState> upDownAnimationAno = 
    GlobalKey<InOutAnimationState>();

  @override
  void initState() {
    super.initState();

    matchIndex = 0;
  }

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
          child: buildCardAnimation()
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

  InOutAnimation buildCardAnimation() {
    return InOutAnimation(
      key: inOutAnimationCard,
      inDefinition: SlideInRightAnimation(),
      outDefinition: SlideOutLeftAnimation(),
      child: Cards()
    );
  }

}