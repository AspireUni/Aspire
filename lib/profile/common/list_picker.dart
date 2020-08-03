import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../../common/common_context.dart';
import '../common/styles.dart';

class ListPicker {
  final List<String> data;
  final List<int> selecteds;
  final void Function(Picker, List<int>) onConfirm;

  ListPicker({
    this.data,
    this.selecteds,
    this.onConfirm
  });

  List<PickerItem<String>> getData() {
    return data.map((item) => PickerItem(
      text: Text(
        item,
        style: pickerTextStyle(
          isCancel: false,
          isButton: false
        )
      ),
      value: item
    )).toList();
  }

  Picker build(BuildContext context) {
    CommonContext().init(context);
    
    return Picker(
      adapter: PickerDataAdapter(data: getData()),
      selecteds: selecteds,
      hideHeader: false,
      height: ScreenSize.height * 0.15,
      itemExtent: 30.0,
      magnification: 1.5,
      squeeze: 0.80,
      diameterRatio: 4.0,
      onConfirm: onConfirm,
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
