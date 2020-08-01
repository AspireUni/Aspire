import 'package:flutter/material.dart';

import '../common/common.dart';
import '../common/global_header.dart';
import '../constants/constants.dart';

class Pairings extends StatelessWidget {
  const Pairings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: GlobalHeader(),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          buildAno(screenHeight),
          Align(
            alignment: Alignment.center, 
            child: buildCardContainer(context, screenWidth, screenHeight)
          ), 
          buildReadMoreButton()
        ]
      )
    );
  }


  Image buildAno(screenHeight) {
    return Image.asset(
      'images/ano_mountains.png',
      height: screenHeight * 0.25
    );
  }

  buildReadMoreButton() {
    return PrimaryButton(
      isLight: true,
      text: readMoreAction,
      onPressed: () => print("Read more pressed")
    );
  }

  Row buildCardHeader(context, screenWidth, screenHeight) {
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

  FormatText buildCardBody(context, screenWidth, screenHeight) {
    return FormatText(
      text: dummyCard["description"], 
      fontSize: 14.0,
      fontWeight: FontWeight.w300,
      fontHeight: 1.6
    );
  }
  
  Row buildCardFooter(context, screenWidth, screenHeight) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: screenWidth * 0.20, 
          height: screenHeight * 0.10, 
          child: FlatButton(
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

  Widget buildCard(context, screenWidth, screenHeight) {
    var sidePadding = screenWidth * 0.05;
    return Padding(
      padding: EdgeInsets.only(
        top: screenHeight * 0.02, 
        left: sidePadding, 
        right: sidePadding
      ),
      child: Column(
        children: [
          buildCardHeader(context, screenWidth, screenHeight),
          buildCardBody(context, screenWidth, screenHeight), 
          buildCardFooter(context, screenWidth, screenHeight)
        ]
      )
    );
  }

  Container buildCardContainer(context, screenWidth, screenHeight) {
    return Container(
      width: screenWidth * 0.80,
      height: screenHeight * 0.42,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).accentColor,
          width: 1.0,
          style: BorderStyle.solid
        ),
        color: Colors.transparent,
        shape: BoxShape.rectangle, 
        borderRadius: BorderRadius.all(Radius.circular(20))
      ), 
      child: buildCard(context, screenWidth, screenHeight)
    );
  }

}