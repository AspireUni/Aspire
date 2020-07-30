import 'package:flutter/material.dart';

import 'format_text.dart';

class InfoBorder extends StatelessWidget {
  final String text;
  final double width;
  final double height;

  InfoBorder({
    Key key, 
    @required this.text,
    this.width,
    this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.50,
      padding: EdgeInsets.only(top: 10.0, bottom: 10),
      alignment: Alignment.center,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.all(Radius.circular(20.0))
        )
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