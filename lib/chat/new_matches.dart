import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../constants/chat_constants.dart';
// import '../constants/common_constants.dart';
import '../models/models.dart';
import '../selectors/selectors.dart';
import '../services/user_service.dart';
import './chat_messenger.dart';


const dummyData = [
  {
    "name": "Charles",
    "color": Colors.blue,
  },
  {
    "name": "Rebecca",
    "color": Colors.purple,
  },
  {
    "name": "Mike",
    "color": Colors.green,
  },
  {
    "name": "Hawk",
    "color": Colors.orange,
  },
  {
    "name": "Pat",
    "color": Colors.yellow,
  },
  {
    "name": "Maweenie",
    "color": Colors.red,
  },
  {
    "name": "Simp",
    "color": Colors.indigo,
  },
  {
    "name": "Igotalongnamewowitisreallysosolong",
    "color": Colors.black,
  },
];

class NewMatches extends StatefulWidget {
  final List<Match> newMatchesList;
  const NewMatches({Key key, @required this.newMatchesList}): super(key: key);

  @override
  _NewMatchesState createState() => _NewMatchesState();
}

class _NewMatchesState extends State<NewMatches> {

  Store<AppState> store;
  String uid;

  bool isMatchesLoaded;

  final List<User> _matchesList = [];

  @override
  void initState() {
    super.initState();

    isMatchesLoaded = false;

    loadMatches();
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);
    uid = userIdSelector(store);

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            chatNewMatchesTitle, 
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
        buildNewMatches(context, _matchesList) :
        Text("loading")
      ]
    );
  }

  loadMatches() async {
    print(widget.newMatchesList.runtimeType);
    for (var match in widget.newMatchesList) {
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

buildNewMatches(context, matchesList) async {
  var newMatchesWidgetList = <Widget>[];
  for (var match in matchesList) {
    newMatchesWidgetList.add(
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => 
              ChatMessenger(recipient: match.fullName, peerId: match.id)
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
                  color: dummyData[0]["color"], 
                  shape: BoxShape.circle
                )
              ),
              Text(
                match.fullName,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.muli(
                  textStyle: TextStyle(
                    color: Colors.black, 
                    letterSpacing: .5, 
                    fontSize: 12.0, 
                    fontWeight: FontWeight.w600
                  )
                )
              )
            ]
          )
        )
      ),
    );
  }


  // for (var i = 0; i < newMatchesList; i++) {
  //   newMatchesList.add(
  //     GestureDetector(
  //       onTap: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (context) => 
  //             ChatMessenger(recipient: dummyData[i]["name"], peerId: mockPeerId)
  //           )
  //         );
  //       },
  //       child: Container(
  //         width: 80.0,
  //         height: 80.0,
  //         color: Colors.transparent,
  //         child: Column(
  //           children: <Widget>[
  //             Container(
  //               width: 60.0, 
  //               height: 60.0, 
  //               decoration: BoxDecoration(
  //                 color: dummyData[i]["color"], 
  //                 shape: BoxShape.circle
  //               )
  //             ),
  //             Text(
  //               dummyData[i]["name"],
  //               overflow: TextOverflow.ellipsis,
  //               style: GoogleFonts.muli(
  //                 textStyle: TextStyle(
  //                   color: Colors.black, 
  //                   letterSpacing: .5, 
  //                   fontSize: 12.0, 
  //                   fontWeight: FontWeight.w600
  //                 )
  //               )
  //             )
  //           ]
  //         )
  //       )
  //     ),
  //   );
  // }

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: newMatchesWidgetList,
    )
  );
}