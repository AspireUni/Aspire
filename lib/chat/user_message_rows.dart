import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../constants/chat_constants.dart';
import './chat_messenger.dart';

const dummyData = [
  {
    "name": "Lydia",
    "color": Colors.blue,
    "lastMessage": "What's that snap",
    "isSent": true,
  },
  {
    "name": "Ashley",
    "color": Colors.purple,
    "lastMessage": "Hey there 😛",
    "isSent": true,
  },
  {
    "name": "Mike",
    "color": Colors.green,
    "lastMessage": "I'm taking that as a yes",
    "isSent": true,
  },
  {
    "name": "Hawk",
    "color": Colors.orange,
    "lastMessage": "U can get this dick",
    "isSent": true,
  },
  {
    "name": "Pat",
    "color": Colors.yellow,
    "lastMessage": "Your welcome handsome! I'm fine just doing some laundry!",
    "isSent": false,
  },
  {
    "name": "Maweenie",
    "color": Colors.red,
    "lastMessage": "Damn that's crazy",
    "isSent": false,
  },
  {
    "name": "Simp",
    "color": Colors.indigo,
    "lastMessage": "wow",
    "isSent": false,
  },
];

class UserMessageRows extends StatelessWidget {
  UserMessageRows({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        buildMessageRows(context)
      ]
    );
  }
}

buildMessageRows(context) {
  List<Widget> messagesList = <Widget>[];
  for (int i = 0; i < dummyData.length; i++) {
    messagesList.add(
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ChatMessenger(recipient: dummyData[i]["name"])));
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
                    color: dummyData[i]["color"], 
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
                    dummyData[i]["name"],
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
                        if(dummyData[i]["isSent"] != false) WidgetSpan(
                          child: Container(
                            margin: EdgeInsets.only(right: 6.0),
                            child: Icon(Icons.send, size: 12, color: Colors.grey)
                          ),
                        ),
                        TextSpan(
                          text: dummyData[i]["lastMessage"]
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