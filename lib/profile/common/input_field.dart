import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  final bool enabled;
  final String labelText;
  final Widget formField;

  InputField({
    Key key,
    this.enabled,
    @required this.labelText,
    @required this.formField
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildFieldLabel(),
          formField
        ]
      )
    );
  }

  Widget buildFieldLabel() {
    var isEnabled = enabled ?? true;

    return Container(
      padding: EdgeInsets.all(0.0),
      child: Text(
        labelText,
        style: GoogleFonts.muli(
          textStyle: TextStyle(
            color: isEnabled ? Colors.black : Colors.black38, 
            letterSpacing: .5, 
            fontSize: 12.0, 
            fontWeight: FontWeight.w600
          )
        )
      )
    );
  }
}
