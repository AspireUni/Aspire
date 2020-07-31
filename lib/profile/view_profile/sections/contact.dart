import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../chat/chat_messenger.dart';
import '../../../constants/profile_constants.dart';
import '../../../models/models.dart';
import '../../../selectors/selectors.dart';
import '../../common/section.dart';

 
class ProfileContact extends StatelessWidget {
  final User user;
  final String matchId;
  final bool viewOnly;

  ProfileContact(
    {Key key, @required this.user, this.matchId, this.viewOnly}
  ) : super(key: key);

  final IconData chat = IconData(
    chatIconCodePoint,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );
  
  final IconData email = IconData(
    emailIconCodePoint,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );

  final IconData phone = IconData(
    phoneIconCodePoint,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );

  final IconData web = IconData(
    webIconCodePoint,
    fontFamily: CupertinoIcons.iconFont,
    fontPackage: CupertinoIcons.iconFontPackage
  );

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
        // TODO: This row should only be visible 
        // when the user is viewing other uses' profiles
        if (!viewOnly) 
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
          user.contact.emailAddress,
          handleEmailTap
        ),
        buildInfoRow(
          context,
          phone,
          contactPhoneNumber,
          user.contact.phoneNumber,
          handlePhoneTap
        ),
        buildInfoRow(
          context,
          web,
          contactWebsite,
          user.contact.website,
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
    return info != '' ? InkWell(
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
    ) : SizedBox();
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

  void handleChatTap(BuildContext context) {
    var store = StoreProvider.of<AppState>(context);
    var uid = userIdSelector(store);
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => ChatMessenger(
          recipient: user,
          groupChatId: matchId,
          senderId: uid
        )
      )
    );
  }

  void handleEmailTap() {
    _launchUrl("mailto:${user.contact.emailAddress}");
  }

  void handlePhoneTap() {
    _launchUrl("tel:${user.contact.phoneNumber}");
  }

  void handleWebsiteTap() {
    _launchUrl(user.contact.website);
  }

  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

}

