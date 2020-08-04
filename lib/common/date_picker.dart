import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import './common.dart';

class DatePicker {
  final String titleText;
  final bool yearOnly;
  final DateTime initialValue;
  final DateTime minValue;
  final DateTime maxValue;
  final void Function(Picker, List<int>) onConfirm;

  DatePicker({
    @required this.titleText,
    @required this.yearOnly,
    @required this.onConfirm,
    @required this.initialValue,
    @required this.maxValue,
    this.minValue,
  });

  Picker build(BuildContext context) {
    return Picker(
      adapter: DateTimePickerAdapter(
        value: initialValue,
        customColumnType: yearOnly ? [0] : [1, 0],
        isNumberMonth: false,
        minValue: minValue,
        maxValue: maxValue,
      ),
      textStyle: modalTextStyle(
        color: ThemeColors.primary,
        isButton: false
      ),
      confirmTextStyle: modalTextStyle(
        color: ThemeColors.accent, 
        isButton: true
      ),
      cancel: buildTitle(),
      textAlign: TextAlign.right,
      onConfirm: onConfirm,
      hideHeader: false,
      height: ScreenSize.height * 0.30,
      itemExtent: 30.0,
      magnification: 1.5,
      squeeze: 0.80,
      diameterRatio: 4.0,
    );
  }

  Widget buildTitle() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: FormatText(
        text: titleText,
        textColor: ThemeColors.primary, 
        fontSize: 15.0,
        fontWeight: FontWeight.w600
      )
    );
  }
}
