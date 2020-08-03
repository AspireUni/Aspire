import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';

import '../constants/constants.dart';
import './common.dart';

class MultiSelectModal extends StatelessWidget {
  final String hintText;
  final List<String> values;
  final List<String> options;
  final Function(List<String>) onConfirm;
  final Function(
    BuildContext,
    SmartSelectState<String>,
    void Function(BuildContext)
  ) field;
  
  MultiSelectModal({
    Key key,
    @required this.hintText,
    @required this.values,
    @required this.options,
    @required this.onConfirm,
    @required this.field
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartSelect<String>.multiple(
      padding: EdgeInsets.all(0),
      title: hintText,
      dense: true,
      value: values,
      options: SmartSelectOption.listFrom<String, String>(
        source: options,
        value: (index, item) => item,
        title: (index, item) => item,
      ),
      onChange: onConfirm,
      modalType: SmartSelectModalType.bottomSheet,
      choiceType: SmartSelectChoiceType.chips,
      modalConfig: getModalConfig(context),
      choiceConfig: getChoiceConfig(context),
      builder: field
    );
  }

  SmartSelectModalConfig getModalConfig(BuildContext context) {
    return SmartSelectModalConfig(
      useConfirmation: true,
      headerStyle: SmartSelectModalHeaderStyle(
        elevation: 0.0,
        shape: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.3
          ),
        ),
        textStyle: modalTextStyle(
          color: Theme.of(context).primaryColor,
          isButton: true
        )
      ),
      style: SmartSelectModalStyle(backgroundColor: Colors.white),
      confirmationBuilder: buildConfirmAction,
    );
  }

  Widget buildConfirmAction(BuildContext context, Function onConfirm) {
    return Container(
      alignment: Alignment.center,
      padding: (EdgeInsets.only(right: 10.0)),
      child: InkWell(
        onTap: onConfirm,
        child: FormatText(
          text: confirmModalAction,
          textColor: Theme.of(context).accentColor, 
          fontSize: 15.0,
          fontWeight: FontWeight.w600
        )
      )
    );
  }

  SmartSelectChoiceConfig<String> getChoiceConfig(BuildContext context) {
    return SmartSelectChoiceConfig(
      style: SmartSelectChoiceStyle(
        activeColor: Colors.white,
        inactiveColor: Theme.of(context).accentColor,
        inactiveTrackColor: Colors.white,
        checkColor:Theme.of(context).accentColor,
        titleStyle: fieldTextStyle(),
      )
    );
  }
}