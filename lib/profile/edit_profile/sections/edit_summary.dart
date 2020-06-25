import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

class EditSummary extends StatefulWidget {
  final String summary;
  EditSummary({Key key, @required this.summary}) : super(key: key);

  @override
  _EditSummaryState createState() => _EditSummaryState();
}

class _EditSummaryState extends State<EditSummary> {
  ValueChanged _onChanged = (val) => print(val);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          FormBuilderTextField(
            attribute: "summary",
            initialValue: widget.summary,
            decoration: InputDecoration(
              hintText: "Tell us about yourself...",
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none
            ),
            style: GoogleFonts.muli(
              textStyle: TextStyle(
                color: Colors.black, 
                letterSpacing: .5, 
                fontSize: 13.0, 
              )
            ),
            onChanged: _onChanged,
            validators: [
              FormBuilderValidators.required(),
              FormBuilderValidators.maxLength(500),
            ],
            keyboardType: TextInputType.text,
            minLines: 5,
            maxLines: 10
          )
        ]
      )
    );
  }
}
