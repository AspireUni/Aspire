import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../chat/chat_messenger.dart';
import '../../../constants/profile_constants.dart';
import '../../common/section.dart';

 
class ProfileContact extends StatelessWidget {  
  final Map contact;
  final String fullName;
  ProfileContact({Key key, @required this.contact, @required this.fullName}) 
    : super(key: key);

  final IconData chat = IconData(
    62459,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );
  
  final IconData email = IconData(
    0xf422,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );

  final IconData phone = IconData(
    0xf4b8,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );

  final IconData web = IconData(
    0xf4d2,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );

  void handleChatTap(BuildContext context) {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => 
      ChatMessenger(recipient: fullName)
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      title: sectionTitleContact,
      child: buildInfoList(context)
    );
  }

  Widget buildInfoList(BuildContext context) {
    return SectionList(
      children: <Widget>[
        buildInfoRow(
          context, 
          chat, 
          contactChat, 
          contactChatSubtitle,
          () => handleChatTap(context)
        ),
        buildInfoRow(
          context, 
          email, 
          contactEmailAddress, 
          contact["emailAddress"],
          handleEmailTap
        ),
        buildInfoRow(
          context,
          phone,
          contactPhoneNumber,
          contact["phoneNumber"],
          handlePhoneTap
        ),
        buildInfoRow(
          context,
          web,
          contactWebsite,
          contact["website"],
          handleWebsiteTap
        )
      ]
    );
  }

  Widget buildInfoRow(
    BuildContext context, 
    IconData iconName, 
    String label, 
    String info, 
    Function() handleTap
  ) {
    return InkWell(
      onTap: handleTap,
      child: SectionRow(
        children: <Widget> [
          Container(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Icon(
              iconName,
              color: Colors.black45,
              size: 25.0,
            )
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildContactText(label, isLabel: true),
              buildContactText(info, isLabel: false)
            ]
          )
        ]
      )
    );
  }

  Widget buildContactText(String text, {bool isLabel}) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: isLabel ? Colors.black : Colors.black54,
          letterSpacing: .5,
          height: 1.2,
          fontSize: 13.0,
          fontWeight: isLabel ? FontWeight.w700 : FontWeight.w500
        ),
      )
    );
  }

  void handleEmailTap() {
    _launchUrl("mailto:${contact["emailAddress"]}");
  }

  void handlePhoneTap() {
    _launchUrl("tel:${contact["phoneNumber"]}");
  }

  void handleWebsiteTap() {
    _launchUrl(contact["website"]);
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

}

