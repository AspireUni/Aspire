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
    return Picker(
      adapter: PickerDataAdapter(data: getData(context)),
      selecteds: selecteds,
      hideHeader: false,
      height: MediaQuery.of(context).size.height * 0.30,
      itemExtent: 30.0,
      magnification: 1.5,
      squeeze: 0.80,
      diameterRatio: 4.0,
      onConfirm: onConfirm,
      builderHeader: buildHeader
    );
  }

  List<PickerItem<String>> getData(BuildContext context) {
    return data.map((item) => PickerItem(
      text: FormatText(
        text: item,
        textColor: Theme.of(context).primaryColor, 
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
          buildTitle(context),
          buildConfirmAction(context)
        ]
      )
    );
  }

  Widget buildTitle(BuildContext context) {
    return FormatText(
      text: titleText,
      textColor: Theme.of(context).primaryColor, 
      fontSize: 15.0,
      fontWeight: FontWeight.w600
    );
  }

  Widget buildConfirmAction(BuildContext context) {
    return InkWell(
      onTap: () => build(context).doConfirm(context),
      child: FormatText(
        text: confirmModalAction,
        textColor: Theme.of(context).accentColor, 
        fontSize: 15.0,
        fontWeight: FontWeight.w600
      ),
    );
  }
}
