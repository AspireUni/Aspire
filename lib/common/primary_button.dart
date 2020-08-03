import 'package:flutter/material.dart';

import './common_context.dart';
import './format_text.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool isLight;
  final double minWidth;
  final double height;

  PrimaryButton({
    Key key, 
    @required this.text,
    @required this.onPressed,
    @required this.isLight,
    this.minWidth,
    this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CommonContext().init(context);

    return MaterialButton(
      minWidth: minWidth ?? MediaQuery.of(context).size.width * 0.50,
      height: height,
      onPressed: onPressed,
      color: isLight 
        ? ThemeColors.accent
        : ThemeColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))
      ),
      child: FormatText(
        text: text,
        textColor: Colors.white,
        textAlign: TextAlign.center,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
    );
  }
}