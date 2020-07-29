import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

import '../common/format_text.dart';
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
    var isRead = !isSent && lastMessage.isRead == true;
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
        child: Container(
          margin: EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 15.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: isRead || isSent ? 
                Colors.grey : 
                Theme.of(context).accentColor, 
              width: 1.0
            ),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
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
                    Row(
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
                            style: TextStyle(
                              color: isRead || isSent ? 
                                Colors.grey : 
                                Theme.of(context).accentColor,
                            ),
                            text: lastMessageType == 0 ? 
                              lastMessage.content : 
                              imageMessageDesciption
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