import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../../../actions/actions.dart';
import '../../../../constants/profile_constants.dart';
import '../../../../models/models.dart';
import '../../../../selectors/selectors.dart';
import '../../../common/styles.dart';

class SaveSummary extends StatefulWidget {
  SaveSummary({Key key}) : super(key: key);

  @override
  _SaveSummaryState createState() => _SaveSummaryState();
}

class _SaveSummaryState extends State<SaveSummary> {

  Store<AppState> store; 

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    return StoreConnector<AppState, SaveProfileState>(
      converter: saveProfileStateSelector,
      builder: (context, state) => Container(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: <Widget>[
            FormBuilderTextField(
              attribute: 'summary',
              initialValue: state.summary,
              decoration: InputDecoration(
                hintText: summaryHintMessage,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none
              ),
              style: fieldTextStyle,
              onChanged: (value) => store.dispatch(UpdateSummary(value)),
              validators: [FormBuilderValidators.maxLength(500)],
              keyboardType: TextInputType.text,
              minLines: 5,
              maxLines: 10
            )
          ]
        )
      )
    );
  }
}
