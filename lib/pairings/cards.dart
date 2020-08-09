import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

import '../common/common.dart';
import '../constants/constants.dart';

class Cards extends StatefulWidget {
  const Cards({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Cards();
}

class _Cards extends State<Cards> {
  int matchIndex;
  final GlobalKey<InOutAnimationState> inOutAnimationCard = 
    GlobalKey<InOutAnimationState>();

  @override
  void initState() {
    super.initState();

    matchIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return InOutAnimation(
      key: inOutAnimationCard,
      inDefinition: SlideInRightAnimation(),
      outDefinition: SlideOutLeftAnimation(),
      child: buildCards()
    );
  }

  void getNextCard() async {
    inOutAnimationCard.currentState.animateOut();
    await Future.delayed(Duration(milliseconds: 500));
    matchIndex == 1 
      ? setState(() { matchIndex = 0; }) 
      : setState(() { matchIndex += 1; });
    inOutAnimationCard.currentState.animateIn();
  }

  Widget buildCards() {
    return Container(
      width: ScreenSize.width * 0.80,
      height: ScreenSize.height * 0.42,
      decoration: buildCardContainer(), 
      child: Stack(
        overflow: Overflow.visible, 
        alignment: Alignment.center, 
        children: [
          buildCardContent(), 
          Positioned(
            top: ScreenSize.height * 0.39, 
            child: buildReadMoreButton()
          )
        ]
      )
    );
  }

  BoxDecoration buildCardContainer() {
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

  Widget buildCardContent() {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: ScreenSize.height * 0.02, 
        horizontal: ScreenSize.width * 0.05
      ),
      child: Column(
        children: [
          buildCardHeader(),
          buildCardSummary(), 
          Spacer(), 
          buildCardFooter()
        ]
      )
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
            text: dummyCard[matchIndex]["name"],
            fontSize: 22.0
          )
        )
      ]
    );
  }

  FormatText buildCardSummary() {
    return FormatText(
      text: dummyCard[matchIndex]["description"], 
      fontSize: 12.0,
      fontWeight: FontWeight.w300,
      fontHeight: 1.6
    );
  }
  
  Row buildCardFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: getNextCard,
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

}