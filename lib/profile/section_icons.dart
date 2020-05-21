import 'package:flutter/material.dart';
import './icon_button.dart';
 
class ProfileSectionIcons extends StatelessWidget {  
  final String activeSection;
  final void Function(String value) handlePress;

  const ProfileSectionIcons({
    Key key, 
    @required this.activeSection, 
    @required this.handlePress
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ProfileIconButton(
          name: Icons.done, 
          caption: "Skills", 
          onPressed: handlePress,
          activeSection: activeSection
        ),
        ProfileIconButton(
          name: Icons.subject, 
          caption: "Bio", 
          onPressed: handlePress,
          activeSection: activeSection
        ),
        ProfileIconButton(
          name: Icons.person_outline, 
          caption: "Info",
          onPressed: handlePress,
          activeSection: activeSection
        ),
      ],
    );
  }
}