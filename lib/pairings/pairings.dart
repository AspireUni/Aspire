import 'package:flutter/material.dart';

import '../common/global_header/global_header.dart';
import './pairings_card.dart';

class Pairings extends StatelessWidget {
  const Pairings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 50.0),
        child: Container(
          child: Column(
            children: buildPairingsView(context)
          )
        )
      )
    );
  }
}

buildPairingsView(BuildContext context) {
  return (
    <Widget>[
      GlobalHeader(), 
      PairingsCard()
    ]
  );
}