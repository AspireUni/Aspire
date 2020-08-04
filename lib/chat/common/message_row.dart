import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../common/common.dart';
import '../../constants/constants.dart';
import '../../models/models.dart';
import '../chat_messenger.dart';
import './profile_picture.dart';

class MessageRow extends StatelessWidget {
  final User recipient;
  final String id;
  final Match match;
  MessageRow(
    {
      Key key, 
      @required this.recipient,
      @required this.id,
      @required this.match,
    }
  ) : super(key: key);

  Widget buildLastMessage(
    context,
    isSent,
    isRead,
    lastMessage,
    lastMessageType
  ) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: GoogleFonts.muli(
          textStyle: TextStyle(
            color: Colors.grey,
            letterSpacing: .5, 
            fontSize: 12.0, 
          )
        ),
        children: [
          if(isSent != false)
            WidgetSpan(
              child: Container(
                margin: EdgeInsets.only(right: 6.0),
                child: Icon(
                  Icons.send, 
                  size: 12, 
                  color: Colors.grey
                )
              ),
            ),
          TextSpan(
            style: TextStyle(
              color: isRead == true || isSent == true ? 
                Colors.grey : 
                ThemeColors.accent,
            ),
            text: lastMessageType == 0 ? 
              lastMessage.content : 
              imageMessageDesciption
          )
        ]
      ),
    );
  }

  Widget buildNameAndTimestamp(lastMessage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FormatText(
          text: recipient.fullName,
          fontSize: 14.0,
        ),
        Container(
          padding: EdgeInsets.only(right: 10.0),
          child: FormatText(
            text: DateFormat('jm').format(
              DateTime.fromMillisecondsSinceEpoch(
                int.parse(lastMessage.timestamp)
              )
            ),
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            textColor: Colors.grey,
          )
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var lastMessage = match.lastMessage;
    var lastMessageType = lastMessage.type;
    var isSent = lastMessage.idFrom == id;
    var isRead = !isSent && lastMessage.isRead;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.push(
          context, 
          MaterialPageRoute(builder: (context) => 
            ChatMessenger(
              recipient: recipient, 
              senderId: id,
              groupChatId: match.matchId,
            )
          )
        );
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isRead || isSent ? 
              Colors.grey : 
              ThemeColors.accent, 
            width: 1.0
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max, 
          children: <Widget>[
            ProfilePicture(
              containerSideLength: 80.0,
              profilePictureRadius: 60.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildNameAndTimestamp(lastMessage),
                  buildLastMessage(
                    context,
                    isSent,
                    isRead,
                    lastMessage,
                    lastMessageType
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}