import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import './common.dart';

class ListPicker {
  final String titleText;
  final List<String> data;
  final List<int> selecteds;
  final void Function(Picker, List<int>) onConfirm;

  ListPicker({
    @required this.titleText,
    @required this.data,
    @required this.selecteds,
    @required this.onConfirm
  });

  Picker build(BuildContext context) {
    return Picker(
      adapter: PickerDataAdapter(data: getData()),
      selecteds: selecteds,
      onConfirm: onConfirm,
      hideHeader: false,
      height: ScreenSize.height * 0.30,
      itemExtent: 30.0,
      magnification: 1.5,
      squeeze: 0.80,
      diameterRatio: 4.0,
      cancel: buildTitle(),
      confirmTextStyle: modalTextStyle(
        color: ThemeColors.accent, 
        isButton: true
      ),
    );
  }

  List<PickerItem<String>> getData() {
    return data.map((item) => PickerItem(
      text: FormatText(
        text: item,
        textColor: ThemeColors.primary, 
        fontSize: 15.0,
        fontWeight: FontWeight.normal
      ),
      value: item
    )).toList();
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
