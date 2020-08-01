import 'package:flutter/material.dart';

import '../common/common.dart';
import '../common/global_header.dart';
import '../constants/constants.dart';

double screenWidth;
double screenHeight;

class Pairings extends StatelessWidget {
  const Pairings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    screenWidth ??= MediaQuery.of(context)?.size?.width;
    screenHeight ??= MediaQuery.of(context)?.size?.height;

    return Scaffold(
      appBar: GlobalHeader(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          buildAno(),
          Align(
            alignment: Alignment.center, 
            child: buildCards(context)
          )
        ]
      )
    );
  }


  Image buildAno() {
    return Image.asset(
      'images/ano_mountains.png',
      height: screenHeight * 0.25
    );
  }

  PrimaryButton buildReadMoreButton() {
    return PrimaryButton(
      isLight: true,
      text: readMoreAction,
      onPressed: () => print("Read more pressed")
    );
  }

  Row buildCardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: screenWidth * 0.10, 
          height: screenHeight * 0.10,
          decoration: BoxDecoration(
            color: Colors.grey[200], 
            shape: BoxShape.circle
          )
        ), 
        Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.03), 
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
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      fontHeight: 1.6
    );
  }
  
  Row buildCardFooter(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: screenWidth * 0.11, 
          height: screenHeight * 0.10, 
          child: FlatButton(
            padding: EdgeInsets.all(0.0),
            child: Image.asset("images/right_arrow.png"), 
            onPressed: () => print("Arrow pressed")
          )
        ), 
        IconButton(
          icon: Icon(Icons.favorite),
          iconSize: screenHeight * 0.03, 
          color: Theme.of(context).accentColor,
          onPressed: () => print("Heart pressed"),
        )
      ]
    );
  }

  Widget buildCurrentCard(context) {
    var sidePadding = screenWidth * 0.05;
    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight * 0.02, 
        left: sidePadding, 
        right: sidePadding
      ),
      child: Column(
        children: [
          buildCardHeader(),
          buildCardBody(), 
          buildCardFooter(context)
        ]
      )
    );
  }

  BoxDecoration buildCardContainer(context) {
    return BoxDecoration(
      border: Border.all(
        color: Theme.of(context).accentColor,
        width: 1.0,
        style: BorderStyle.solid
      ),
      color: Colors.transparent,
      shape: BoxShape.rectangle, 
      borderRadius: BorderRadius.all(Radius.circular(20))
    );
  }

  Container buildCards(context) {
    return Container(
      width: screenWidth * 0.80,
      height: screenHeight * 0.42,
      decoration: buildCardContainer(context), 
      child: Stack(
        overflow: Overflow.visible, 
        alignment: Alignment.center, 
        children: [
          buildCurrentCard(context), 
          Positioned(
            top: screenHeight * 0.38, 
            child: buildReadMoreButton()
          )
        ]
      )
    );
  }

}