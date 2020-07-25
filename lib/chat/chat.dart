import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../constants/chat_constants.dart';
import '../constants/common_constants.dart';
import '../models/models.dart';
import '../selectors/selectors.dart';
import '../services/user_service.dart';
import './new_matches.dart';
import './user_message_rows.dart';

class Chat extends StatefulWidget {
  const Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  Store<AppState> store;
  String uid;

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);
    uid = userIdSelector(store);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(0),
        child: Center(
          child: Column(
            children: buildChatView()
          )
        )
      )
    );
  }
}

buildHeader() {
  return Container (
    margin: EdgeInsets.all(30.0),
    child: Column(
      children: <Text>[
        Text(
          chatHeaderTitle, 
          style: GoogleFonts.muli(
            textStyle: TextStyle(
              color: Colors.black, 
              letterSpacing: .5, 
              fontSize: 30.0, 
              fontWeight: FontWeight.bold
            )
          )
        ), 
        Text(
          chatHeaderSubtitle, 
          style: GoogleFonts.muli(
            textStyle: TextStyle(
              color: Colors.grey, 
              letterSpacing: .5, 
              fontSize: 18, 
              fontWeight: FontWeight.w600
            )
          )
        ), 
      ]
    )
  );
}

buildChatView() {
  return (
    <Widget>[
      buildHeader(),
      NewMatches(),
      Flexible(
        child: UserMessageRows(),
      )
    ]
  );
}