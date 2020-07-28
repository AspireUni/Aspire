import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../constants/chat_constants.dart';
import '../models/models.dart';
import '../selectors/selectors.dart';
import './chat_messenger.dart';

class UserMessageRows extends StatefulWidget {
  final List<Match> matchesList;
  const UserMessageRows({Key key, @required this.matchesList});

  @override
  _UserMessageRowsState createState() => _UserMessageRowsState();
}

class _UserMessageRowsState extends State<UserMessageRows> {

  Store<AppState> store;
  String uid;
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);
    uid = userIdSelector(store);
    // TODO: get this from UserState
    var isMentee = true;

    return Column(
      children: <Widget>[
        Padding (
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child:Text(
            chatMessageRowTitle, 
            textAlign: TextAlign.left,
            style: GoogleFonts.muli(
              textStyle: TextStyle(
                color: Colors.black, 
                letterSpacing: .5, 
                fontSize: 18.0, 
                fontWeight: FontWeight.bold
              )
            )
          )
        ),
        buildMessageRows(
          context, 
          widget.matchesList, 
          uid,
          isMentee
        )
      ]
    );
  }
}

buildMessageRows(
  context, 
  matchesList, 
  id,
  isMentee
) {
  var messagesList = <Widget>[];
  for (var match in matchesList) {
    var lastMessage = match.lastMessage;
    var lastMessageType = lastMessage.type;
    var isSent = lastMessage.idFrom == id;
    var recipient = isMentee == true ? match.mentor : match.mentee;
    messagesList.add(
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => 
              ChatMessenger(
              recipient: recipient.fullName, 
                peerId: recipient.id, 
                id: id,
                groupChatId: match.matchId,
              )
            )
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max, 
          children: <Widget>[
            Container(
              width: 80.0,
              height: 80.0,
              child: Center(
                child: Container(
                  width: 60.0, 
                  height: 60.0, 
                  decoration: BoxDecoration(
                    color: Colors.black, 
                    shape: BoxShape.circle
                  )
                )
              )
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    recipient.fullName,
                    style: GoogleFonts.muli(
                      textStyle: TextStyle(
                        color: Colors.black, 
                        letterSpacing: .5, 
                        fontSize: 14.0, 
                        fontWeight: FontWeight.bold
                      )
                    )
                  ),
                  RichText(
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
                        if(isSent != false) WidgetSpan(
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
                          text: lastMessageType == 0 ? 
                            lastMessage.content : 
                            "Sent an image message"
                        )
                      ]
                    ),
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
  return Flexible(
    child: ListView(
      padding: EdgeInsets.all(0.0),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: messagesList,
    )
  );
}