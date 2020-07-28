import 'package:flutter/material.dart';

import '../common/global_header.dart';
import './pairings_card.dart';

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
}

Widget buildPairingsView(BuildContext context) {
  return PairingsCard();
}