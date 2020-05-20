import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

const dummyData = [
  {
    "name": "Lydia",
    "color": Colors.blue,
    "lastMessage": "What's that snap",
  },
  {
    "name": "Ashley",
    "color": Colors.purple,
    "lastMessage": "Hey there 😛",
  },
  {
    "name": "Elizabeth",
    "color": Colors.green,
    "lastMessage": "I'm taking that as a yes",
  },
  {
    "name": "Hawk",
    "color": Colors.orange,
    "lastMessage": "U can get this dick",
  },
  {
    "name": "Pat",
    "color": Colors.yellow,
    "lastMessage": "Your welcome handsome! I'm fine just doing some laundry!",
  },
  {
    "name": "Maweenie",
    "color": Colors.red,
    "lastMessage": "Damn that's crazy",
  },
  {
    "name": "Simp",
    "color": Colors.indigo,
    "lastMessage": "wow",
  },
];

class Messages extends StatelessWidget {
  Messages({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          "Messages", 
          textAlign: TextAlign.left,
          style: GoogleFonts.muli(
            textStyle: TextStyle(
              color: Colors.black, 
              letterSpacing: .5, 
              fontSize: 18.0, 
              fontWeight: FontWeight.bold
            )
          )
        ),
        buildMessages(context)
      ]
    );
  }
}

buildMessages(context) {

  List<Widget> messagesList = new List<Widget>();
  for (int i = 0; i < dummyData.length; i++) {
    messagesList.add(Row(
        mainAxisSize: MainAxisSize.max, 
        children: <Widget>[
          Center(
            widthFactor: 1.3333333333,
            heightFactor: 1.3333333333,
            child: Container(
              width: 60.0, 
              height: 60.0, 
              decoration: BoxDecoration(
                color: dummyData[i]["color"], 
                shape: BoxShape.circle
              )
            )
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Text>[
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
                Text(
                  dummyData[i]["lastMessage"],
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.muli(
                    textStyle: TextStyle(
                      color: Colors.grey,
                      letterSpacing: .5, 
                      fontSize: 12.0, 
                    )
                  )
                )
              ]
            )
          )
        ]
      ),
    );
  }

  return Container(
    child: ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      children: messagesList,
    )
  );
}