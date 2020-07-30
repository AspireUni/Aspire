import 'package:flutter/material.dart';

import './format_text.dart';

class DisabledButton extends StatelessWidget {
  final String text;
  final double minWidth;
  final double height;

  DisabledButton({
    Key key, 
    @required this.text,
    this.minWidth,
    this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: minWidth ?? MediaQuery.of(context).size.width * 0.50,
      height: height,
      elevation: 0.0,
      enableFeedback: false,
      onPressed: () => {},
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Theme.of(context).accentColor),
        borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      child: FormatText(
        text: text,
        textColor: Theme.of(context).accentColor,
        textAlign: TextAlign.center,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
    );
  }
}