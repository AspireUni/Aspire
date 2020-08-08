import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

import '../common/common.dart';
import '../constants/constants.dart';

class Pairings extends StatefulWidget {
  const Pairings({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Pairings();
}

class _Pairings extends State<Pairings> {
  int matchIndex;
  final GlobalKey<InOutAnimationState> inOutAnimationText = 
  GlobalKey<InOutAnimationState>();
  final GlobalKey<InOutAnimationState> upDownAno = 
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: ScreenSize.height * 0.04, 
            child: buildCardAnimation(context)
          ),
          Positioned(
            bottom: 0, 
            child: buildAnoAnimation()
          )
        ]
      )
    );
  }

  InOutAnimation buildAnoAnimation() {
      return InOutAnimation(
        key: upDownAno,
        inDefinition: SlideInUpAnimation(),
        outDefinition: SlideOutDownAnimation(),
        child: buildAno()
      );
    }

  InOutAnimation buildCardAnimation(context) {
    return InOutAnimation(
      key: inOutAnimationText,
      inDefinition: SlideInRightAnimation(),
      outDefinition: SlideOutLeftAnimation(),
      child: buildCards(context)
    );
  }

  Image buildAno() {
    return Image.asset(
      'images/ano_mountains.png',
      height: ScreenSize.height * 0.25
    );
  }

  PrimaryButton buildReadMoreButton() {
    return PrimaryButton(
      isLight: true,
      text: readMoreButtonText,
      onPressed: () => print("Read more pressed")
    );
  }

  Row buildCardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: ScreenSize.width * 0.10, 
          height: ScreenSize.height * 0.10,
          decoration: BoxDecoration(
            color: Colors.grey[200], 
            shape: BoxShape.circle
          )
        ), 
        Padding(
          padding: EdgeInsets.only(top: ScreenSize.height * 0.03), 
          child: FormatText(
            text: dummyCard["name"],
            fontSize: 22.0
          )
        )
      ]
    );
  }

  FormatText buildCardBody() {
    return FormatText(
      text: dummyCard["description"], 
      fontSize: 12.0,
      fontWeight: FontWeight.w300,
      fontHeight: 1.6
    );
  }
  
  Row buildCardFooter(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => print("Arrow pressed"),
          child: Image.asset(
            'images/right_arrow.png', 
            height: ScreenSize.height * 0.015
          )
        ),
        IconButton(
          icon: Icon(Icons.favorite),
          iconSize: ScreenSize.height * 0.03, 
          color: ThemeColors.accent,
          onPressed: () => print("Heart pressed"),
        )
      ]
    );
  }

  Widget buildCurrentCard(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.height * 0.02, 
        horizontal: ScreenSize.width * 0.05
      ),
      child: Column(
        children: [
          buildCardHeader(),
          buildCardBody(), 
          Spacer(), 
          buildCardFooter(context)
        ]
      )
    );
  }

  BoxDecoration buildCardContainer(context) {
    return BoxDecoration(
      border: Border.all(
        color: ThemeColors.accent,
        width: 1.0,
        style: BorderStyle.solid
      ),
      color: Colors.transparent,
      shape: BoxShape.rectangle, 
      borderRadius: BorderRadius.all(Radius.circular(20))
    );
  }

  Widget buildCards(context) {
    return Container(
      width: ScreenSize.width * 0.80,
      height: ScreenSize.height * 0.42,
      decoration: buildCardContainer(context), 
      child: Stack(
        overflow: Overflow.visible, 
        alignment: Alignment.center, 
        children: [
          buildCurrentCard(context), 
          Positioned(
            top: ScreenSize.height * 0.39, 
            child: buildReadMoreButton()
          )
        ]
      )
    );
  }

}