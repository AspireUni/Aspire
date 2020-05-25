import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

const dummyData = [
  {
    "text": "Hello",
    "isSent": true,
  },
  {
    "text": "it's me",
    "isSent": false,
  },
  {
    "text": "I was wondering if after all these years you'd like to meet",
    "isSent": true,
  },
  {
    "text": "to go over?",
    "isSent": false,
  },
  {
    "text": "everything.",
    "isSent": true,
  },
  {
    "text": "they say that time's supposed to heal ya",
    "isSent": true,
  },
  {
    "text": "but I ain't done much healing 😠",
    "isSent": true,
  },
];

class ChatMessengerState extends State<ChatMessenger> {
  String recipient;
  List<Object> messages = [...dummyData];

  void addMessage (message, isSent) {
    setState(() {messages = [...messages, {"text": message, "isSent": isSent}];});
  }

  final TextEditingController textInputController = new TextEditingController();

  List<Widget> buildMessages() {
    List<Widget> messagesList = new List<Widget>();
    for (int i = messages.length - 1; i >= 0; i--) {
      messagesList.add(
        Align(
          alignment: (messages[i] as Map)["isSent"] ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              color: (messages[i] as Map)["isSent"] ? Color(0x8F0F1236) : Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
            // margin: EdgeInsets.all(10.0),
            margin: (messages[i] as Map)["isSent"] ? EdgeInsets.fromLTRB(50.0, 10.0, 10.0, 10.0) : EdgeInsets.fromLTRB(10.0, 10.0, 50.0, 10.0),
            padding: EdgeInsets.all(10.0),
            child: Text(
              (messages[i] as Map)["text"],
              overflow: TextOverflow.visible,
              style: GoogleFonts.muli(
                textStyle: TextStyle(
                  color: Colors.white, 
                  letterSpacing: .5, 
                  fontSize: 14.0, 
                )
              )
            )
          )
        )
      );
    }

    return (
      <Widget>[
        Expanded(
          child: ListView(
            reverse: true,
            scrollDirection: Axis.vertical,
            children: messagesList,
          )
        ),
        Container(
          height: 100.0,
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          color: Colors.grey,
          child: TextFormField(
            textInputAction: TextInputAction.send,
            controller: textInputController,
            onFieldSubmitted: (String value) {
              textInputController.text = "";
              if (value != "") {
                addMessage(value, true);
              }
            },
          )
        ),
      ]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white)
            ),
            backgroundColor: Color(0xFF0F1236),
            centerTitle: true,
            title: Text(
              widget.recipient,
              style: GoogleFonts.muli(
              textStyle: TextStyle(
                color: Colors.white, 
                letterSpacing: .5, 
                fontSize: 30.0, 
                fontWeight: FontWeight.bold
              )
          )
            ),
          ),
          backgroundColor: Colors.white,
          body: Container(
            height: MediaQuery.of(context).size.height,
            margin: const EdgeInsets.all(0),
            child: Center(
              child: Column(
                children: buildMessages()
              )
            )
          ),
        ),
      ]
    );
  }

}

class ChatMessenger extends StatefulWidget {
  final String recipient;
  var messages;
  ChatMessenger({Key key, this.recipient, this.messages = dummyData}) : super(key: key);

  @override
  State<ChatMessenger> createState() => ChatMessengerState();

}