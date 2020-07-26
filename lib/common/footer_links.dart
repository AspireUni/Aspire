import 'package:flutter/material.dart';

import '../constants/ftu_constants.dart';
import './format_text.dart';

class FooterLinks extends StatelessWidget {
  FooterLinks({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget> [
        buildTermsAndConditionsLink(context),
        buildLinkDivider(),
        buildPrivacyPolicyLink(context)
      ]
    );
  }
  
  Widget buildLinkDivider() {
    return FormatText(
      text: linkDivider,
      textColor: Colors.grey,
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
    );
  }

  Widget buildTermsAndConditionsLink(BuildContext context) {
    return InkWell(
      onTap: () => print('Terms and Conditions pressed.'),
      child: FormatText(
        text: termsAndConditions,
        textColor: Colors.grey,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
    );
  }

  Widget buildPrivacyPolicyLink(BuildContext context) {
    return InkWell(
      onTap: () => print('Privacy Policy pressed.'),
      child: FormatText(
        text: privacyPolicy,
        textColor: Colors.grey,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
    );
  }
}