import 'package:flutter/material.dart';

import '../common/global_header.dart';

class Pairings extends StatelessWidget {
  const Pairings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalHeader(),
      backgroundColor: Colors.white,
      body: buildPairingsView(context)
    );
  }


  Widget buildAno(screenWidth, screenHeight) {
    return Container(
      width: screenWidth,
      child: Column(
        children: <Widget>[
          Image.asset(
            'images/ano_mountains.png',
            height: screenHeight * 0.25,
          ),
          Container(
            height: 1.5,
            color: Colors.black
          )
        ]
      )
    );
  }

  buildPairingsView(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: <Widget>[
        Positioned(
          top: screenHeight * 0.15,
          child: buildAno(screenWidth, screenHeight)
        ),
      ]
    );
  }
}