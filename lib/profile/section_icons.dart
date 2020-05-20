import 'package:flutter/material.dart';
import './icon_button.dart';
 
class ProfileSectionIcons extends StatelessWidget {  
  const ProfileSectionIcons({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ProfileIconButton(name: Icons.done, caption: "Skills"),
        ProfileIconButton(name: Icons.subject, caption: "Bio"),
        ProfileIconButton(name: Icons.person_outline, caption: "Info"),
      ],
    );
  }
}