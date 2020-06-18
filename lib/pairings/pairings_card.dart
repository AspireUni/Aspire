import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

import "../constants/pairings_constants.dart";

CardController controller;

class PairingsCard extends StatefulWidget {
  @override
  _PairingsCardState createState() => _PairingsCardState();
}

class _PairingsCardState extends State<PairingsCard> 
  with TickerProviderStateMixin {
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height * 0.6,
        child: renderCards(context)
      )
    );
  }
}

renderCards(context) { 
  final totalCardNum = dummyImages.length;
  final maxSize = MediaQuery.of(context).size.width * 0.9;
  final minSize = MediaQuery.of(context).size.width * 0.8;
  
  return TinderSwapCard(
    orientation: AmassOrientation.BOTTOM,
    totalNum: totalCardNum,
    stackNum: 3,
    maxWidth: maxSize, 
    maxHeight: maxSize, 
    minWidth: minSize,
    minHeight: minSize, 
    cardBuilder: (context, index) => Card(
      child: Image.asset('${dummyImages[index]}')
    ),
    cardController: controller = CardController(),
    swipeUpdateCallback:
      (DragUpdateDetails details, Alignment align) {
        if (align.x < 0) {
          // Left swipe
        } else if (align.x > 0) {
          // Right swipe
        }
    },
    swipeCompleteCallback:
      (CardSwipeOrientation orientation, int index) {
      // Orientation & index of swiped card
    }
  );
}