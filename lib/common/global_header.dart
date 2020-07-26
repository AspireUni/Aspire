import 'package:flutter/material.dart';

import '../constants/common_constants.dart';
import 'format_text.dart';

class GlobalHeader extends StatelessWidget implements PreferredSizeWidget {
  final String actionText;
  final void Function() onActionTap;

  GlobalHeader({
    Key key,
    this.actionText,
    this.onActionTap
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var showAction = actionText != null && onActionTap != null;

    return AppBar(
      title: appBarTitle(), 
      actions: <Widget>[appBarAction(context, isVisible: showAction)],
      backgroundColor: Colors.white,
      centerTitle: false,
      elevation: 0.0
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);

  Widget appBarTitle() {
  return FormatText(
    text: appName, 
    fontSize: globalHeaderFontSize,
  );
}

  Widget appBarAction(BuildContext context, {bool isVisible}) {
    return isVisible
      ? Container(
        padding: EdgeInsets.only(
          top: 18.5,
          right: 20
        ),
        child: InkWell(
          onTap: onActionTap,
          child: FormatText(
            text: actionText,
            textColor: Theme.of(context).accentColor,
            fontSize: 13.0,
            fontWeight: FontWeight.w500
            )
        )
      ) : SizedBox();
  }
}