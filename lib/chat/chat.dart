import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../common/common.dart';
import '../constants/constants.dart';
import '../models/models.dart';
import '../selectors/selectors.dart';
import '../services/services.dart';
import './new_matches.dart';
import './user_message_rows.dart';

class Chat extends StatefulWidget {
  const Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  final List<Match> _newMatchesList = [];
  final List<Match> _matchesList = [];

  Store<AppState> store;
  String uid;

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);
    uid = userIdSelector(store);
    // TODO: get this from UserState
    var isMentee = true;

    return FutureBuilder<QuerySnapshot>(
      future: getMatches(uid, isMentee),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingScreen;
        } else {
          for (var document in snapshot.data.documents) {
            var match = Match.fromJson(document.data);
            if (match.hasContacted) {
              _matchesList.add(match);
            } else {
              _newMatchesList.add(match);
            }
          }
          _matchesList.sort(
            (matchA, matchB) => 
              matchB.lastMessage.timestamp.compareTo(
                matchA.lastMessage.timestamp
              )
          );
          return Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.all(0),
              child: Center(
                child: Column(
                  children: buildChatView(_newMatchesList, _matchesList)
                )
              )
            )
          );
        }
      },
    );
  }
}

buildChatView(var newMatchesList, var matchesList) {
  return (
    <Widget>[
      GlobalHeader(
        actionText: "New Message",
        onActionTap: () => {},
      ),
      if (newMatchesList.length != 0)
        NewMatches(newMatchesList: newMatchesList),
      if (matchesList.length != 0)
        Flexible(
          child: UserMessageRows(matchesList: matchesList)
        )
    ]
  );
}