import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../common/common.dart';
import '../models/models.dart';
import '../selectors/selectors.dart';
import './chat_messenger.dart';
import './common/profile_picture.dart';

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
                recipient: recipient, 
                senderId: id, 
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
              ProfilePicture(
                containerSideLength: 60.0, 
                profilePictureRadius: 60.0
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

  return Container(
    width: MediaQuery.of(context).size.width,
    child: Row(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Image.asset('images/onboarding/ano_standing.png', height: 60.0),
              Container(height: 1.5, width: 50, color: Colors.black),
            ]
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: newMatchesWidgetList,
            )
          )
        )
      ]
    )
  );
}