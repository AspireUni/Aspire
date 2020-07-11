import 'package:flutter/material.dart';

import '../../constants/common_constants.dart';
import '../../constants/global_header/global_header_constants.dart';
import '../format_text.dart';

class GlobalHeader extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: addAppBarTextWidget(), 
      height: preferredSize.height,
      padding: EdgeInsets.only(left: 25.0),
      color: Colors.transparent
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}

Row addAppBarTextWidget() {
  return Row(
    children: <Widget>[
      FormatText(
        text: appTitle, 
        fontSize: globalHeaderFontSize,
      ), 
      addAppBarActions()
    ]
  );
}

IconButton addAppBarActions() {
  return IconButton(
    icon: Icon(Icons.filter_list), 
    tooltip: 'Filter your matches', 
    onPressed: () {
      print("Pressed");
    }
  );
}