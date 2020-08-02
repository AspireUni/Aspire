import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../models/models.dart';
import '../selectors/selectors.dart';
import './common/message_row.dart';

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
    var recipient = isMentee == true ? match.mentor : match.mentee;
    messagesList.add(
      MessageRow(
        recipient: recipient,
        match: match,
        id: id
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