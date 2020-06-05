import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:mentorApp/constants/profile_constants.dart';
import './section.dart';
import '../../chat/chat_messenger.dart';

 
class ProfileContact extends StatelessWidget {  
  final Map contact;
  final String fullName;
  ProfileContact({Key key, @required this.contact, @required this.fullName}) : super(key: key);

  final IconData chat = const IconData(
    62459,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );
  
  final IconData email = const IconData(
    0xf422,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );

  final IconData phone = const IconData(
    0xf4b8,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );

  final IconData web = const IconData(
    0xf4d2,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );

  void handleChatTap(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatMessenger(recipient: fullName)));
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      title: SECTION_TITLE_CONTACT,
      child: buildInfoList(context)
    );
  }

  buildInfoList(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildInfoRow(
            context, 
            chat, 
            CONTACT_CHAT, 
            CONTACT_CHAT_SUBTITLE,
            () => handleChatTap(context)
          ),
          buildInfoRow(
            context, 
            email, 
            CONTACT_EMAIL_ADDRESS, 
            contact["emailAddress"],
            handleEmailTap
          ),
          buildInfoRow(
            context,
            phone,
            CONTACT_PHONE_NUMBER,
            contact["phoneNumber"],
            handlePhoneTap
          ),
          buildInfoRow(
            context,
            web,
            CONTACT_WEBSITE,
            contact["website"],
            handleWebsiteTap
          )
        ]
      )
    );
  }

  buildInfoRow(
    BuildContext context, 
    IconData iconName, 
    String label, 
    String info, 
    Function() handleTap
  ) {
    return InkWell(
      onTap: handleTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(bottom: 10.0),
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.black12
            )
          )
        ),
        child: Row(
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
                buildContactText(label, true),
                buildContactText(info, false)
              ]
            )
          ]
        )
      )
    );
  }

  buildContactText(String text, bool isLabel) {
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

  handleEmailTap() {
    _launchUrl("mailto:" + contact["emailAddress"]);
  }

  handlePhoneTap() {
    _launchUrl("tel:" + contact["phoneNumber"]);
  }

  handleWebsiteTap() {
    _launchUrl(contact["website"]);
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

}

