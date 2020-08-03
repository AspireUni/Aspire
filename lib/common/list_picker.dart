import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../common/common.dart';
import '../constants/constants.dart';

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
    CommonContext().init(context);

    return Picker(
      adapter: PickerDataAdapter(data: getData()),
      selecteds: selecteds,
      hideHeader: false,
      height: ScreenSize.height * 0.30,
      itemExtent: 30.0,
      magnification: 1.5,
      squeeze: 0.80,
      diameterRatio: 4.0,
      onConfirm: onConfirm,
      builderHeader: buildHeader
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

  Widget buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 0.3
          ),
        ),
      ),
      padding: EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          buildTitle(),
          buildConfirmAction(context)
        ]
      )
    );
  }

  Widget buildTitle() {
    return FormatText(
      text: titleText,
      textColor: ThemeColors.primary, 
      fontSize: 15.0,
      fontWeight: FontWeight.w600
    );
  }

  Widget buildConfirmAction(BuildContext context) {
    return InkWell(
      onTap: () => build(context).doConfirm(context),
      child: FormatText(
        text: confirmModalAction,
        textColor: ThemeColors.accent, 
        fontSize: 15.0,
        fontWeight: FontWeight.w600
      ),
    );
  }
}
