import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../common/format_text.dart';
import '../constants/chat_constants.dart';
import '../models/models.dart';
import '../selectors/selectors.dart';
import './chat_messenger.dart';

class NewMatches extends StatefulWidget {
  final List<Match> newMatchesList;
  const NewMatches({Key key, @required this.newMatchesList}): super(key: key);

  @override
  _NewMatchesState createState() => _NewMatchesState();
}

class _NewMatchesState extends State<NewMatches> {

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
    // TODO: Get this from UserState
    var isMentee = true;

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: FormatText(
            text: chatNewMatchesTitle,
            textAlign: TextAlign.left,
            fontSize: 18.0,
          )
        ),
        buildNewMatches(
          context, 
          widget.newMatchesList, 
          uid,
          isMentee
        )
      ]
    );
  }
}

buildNewMatches(context, newMatchesList, id, isMentee) {
  var newMatchesWidgetList = <Widget>[];
  for (var match in newMatchesList) {
    var recipient = isMentee == true ? match.mentor : match.mentee;
    newMatchesWidgetList.add(
      GestureDetector(
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
          width: 80.0,
          height: 80.0,
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              Container(
                width: 60.0, 
                height: 60.0, 
                decoration: BoxDecoration(
                  color: Colors.black, 
                  shape: BoxShape.circle
                )
              ),
              Flexible(
                child: FormatText(
                  text: recipient.fullName,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                )
              )
            ]
          )
        )
      ),
    );
  }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: newMatchesWidgetList,
    )
  );
}