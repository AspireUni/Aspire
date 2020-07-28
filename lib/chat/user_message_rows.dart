import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../constants/chat_constants.dart';
import '../models/models.dart';
import '../selectors/selectors.dart';
import '../services/user_service.dart';
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

  bool isMatchesLoaded;

  final List<User> _matchesList = [];

  @override
  void initState() {
    super.initState();
    isMatchesLoaded = false;
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);
    uid = userIdSelector(store);

    if (!isMatchesLoaded) {
      loadMatches(widget.matchesList, uid);
    }

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
        isMatchesLoaded ? 
          buildMessageRows(
            context, 
            _matchesList, 
            widget.matchesList, 
            uid, 
          ) :
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              Theme.of(context).accentColor
            )
          )      
      ]
    );
  }

  loadMatches(List<Match> matchesList, uid) async {
    for (var match in matchesList) {
      if (match.pair[0] == uid) {
        var user = await getUser(match.pair[1]);
        _matchesList.add(User.fromJson(user));
      } else {
        var user = await getUser(match.pair[0]);
        _matchesList.add(User.fromJson(user));
      }
    }

    setState(() {
      isMatchesLoaded = true;
    });
  }
}

buildMessageRows(
  context, 
  matchesPeerList, 
  matchesList, 
  id, 
) {
  var messagesList = <Widget>[];
  for (var i = 0; i < matchesPeerList.length; i++) {
    var lastMessage = matchesList[i].lastMessage;
    var lastMessageType = lastMessage.type;
    var isSent = lastMessage.idFrom == id;
    messagesList.add(
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => 
              ChatMessenger(
              recipient: matchesPeerList[i].fullName, 
                peerId: matchesPeerList[i].id, 
                id: id,
                groupChatId: matchesList[i].matchId,
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
                    matchesPeerList[i].fullName,
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