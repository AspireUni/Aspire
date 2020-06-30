import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../constants/profile_constants.dart';
import '../../../common/styles.dart';

class EditSummary extends StatefulWidget {
  final String summary;
  
  EditSummary({Key key, @required this.summary}) : super(key: key);

  @override
  _EditSummaryState createState() => _EditSummaryState();
}

class _EditSummaryState extends State<EditSummary> {

  String summary;

  @override
  void initState() {
    super.initState();

    // Temporary workaround until we use global state management
    summary = widget.summary;
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          FormBuilderTextField(
            attribute: 'summary',
            initialValue: summary,
            decoration: InputDecoration(
              hintText: summaryHintMessage,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none
            ),
            style: fieldTextStyle,
            onChanged: (value) => setState(() { summary = value as String; }),
            validators: [FormBuilderValidators.maxLength(500)],
            keyboardType: TextInputType.text,
            minLines: 5,
            maxLines: 10
          )
        ]
      )
    );
  }
}
