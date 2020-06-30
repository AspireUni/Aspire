import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../common/styles.dart';

class DatePicker {
  final bool yearOnly;
  final DateTime initialValue;
  final DateTime minValue;
  final DateTime maxValue;
  final void Function(Picker, List<int>) onConfirm;

  DatePicker({
    this.yearOnly,
    this.initialValue,
    this.minValue,
    this.maxValue,
    this.onConfirm
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
      textAlign: TextAlign.right,
      onConfirm: onConfirm,
      hideHeader: false,
      height: MediaQuery.of(context).size.height * 0.30,
      itemExtent: 30.0,
      magnification: 1.5,
      squeeze: 0.80,
      diameterRatio: 4.0,
      textStyle: pickerTextStyle(
        isCancel: false,
        isButton: false
      ),
      cancelTextStyle: pickerTextStyle(
        isCancel: true,
        isButton: true
      ),
      confirmTextStyle: pickerTextStyle(
        isCancel: false,
        isButton: true
      ),
    );
  }
}
