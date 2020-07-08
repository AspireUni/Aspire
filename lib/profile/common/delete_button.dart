import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../common/styles.dart';

class DeleteButton extends StatelessWidget {
  final String labelText;
  final void Function() onPressed;

  DeleteButton({Key key, @required this.labelText, @required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))
        ),
        child: Text(
          labelText,
          style: deleteButtonTextStyle
        )
      )
    );
  }
}
