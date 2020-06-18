import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './message.dart';

const dummyData = [
  {
    "text": "Hello",
    "isSent": true,
    "timestamp": '2020-06-04 09:36'
  },
  {
    "text": "it's me",
    "isSent": false,
    "timestamp": '2020-06-04 09:36'
  },
  {
    "text": "I was wondering if after all these years you'd like to meet",
    "isSent": true,
    "timestamp": '2020-06-04 09:37'
  },
  {
    "text": "to go over?",
    "isSent": false,
    "timestamp": '2020-06-04 09:38'
  },
  {
    "text": "everything.",
    "isSent": true,
    "timestamp": '2020-06-04 09:39'
  },
  {
    "text": "they say that time's supposed to heal ya",
    "isSent": true,
    "timestamp": '2020-06-04 09:41'
  },
  {
    "text": "but I ain't done much healing 😠",
    "isSent": true,
    "timestamp": '2020-06-04 09:42'
  },
];

class ChatMessengerState extends State<ChatMessenger> {
  String recipient;
  List<Object> messages = [...dummyData];

  void addMessage (message, timestamp, isSent) {
    setState(() {messages = [...messages, {"text": message, "isSent": isSent, "timestamp": timestamp}];});
  }

  void submitMessage (String value) {
    textInputController.text = "";
    if (value != "") {
      String timestamp = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now());
      addMessage(value, timestamp, true);
      SystemSound.play(SystemSoundType.click);
    }
  }

  Widget buildTimestamp(String timestamp, {bool isSent}) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child:  Container(
        margin: isSent ? EdgeInsets.fromLTRB(50.0, 0.0, 10.0, 10.0) : EdgeInsets.fromLTRB(10.0, 10.0, 50.0, 10.0),
        child: Text (
          DateFormat('jm').format(DateFormat('yyyy-MM-dd kk:mm').parse(timestamp)),
          style: GoogleFonts.muli(
            textStyle: TextStyle(
              color: Colors.grey, 
              letterSpacing: .5, 
              fontSize: 11.0, 
            )
          )
        )
      )
    );
  }

  Widget buildMessengerKeyboard() {
    return Container(
      constraints: BoxConstraints(minHeight: 70.0, maxHeight: 200.0),
      padding: EdgeInsets.only(bottom: 15.0),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...'
              ),
              style: GoogleFonts.muli(
                textStyle: TextStyle(
                  color: Colors.black, 
                  letterSpacing: .5, 
                  fontSize: 14.0, 
                )
              ),
              maxLines: null, // this allows for multi-line input
              textInputAction: TextInputAction.send,
              controller: textInputController,
              onSubmitted: submitMessage,
            )
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () => submitMessage(textInputController.value.text),
          ),
        ]
      )
    );
  }

  final TextEditingController textInputController = new TextEditingController();

  List<Widget> buildMessenger() {
    List<Widget> messagesList = new List<Widget>();
    for (int i = messages.length - 1; i >= 0; i--) {
      if (i == messages.length - 1) {
        messagesList.add(
          buildTimestamp((messages[i] as Map)["timestamp"], isSent: (messages[i] as Map)["isSent"])
        );
      }
      messagesList.add(
        Message(message: (messages[i] as Map)["text"], isSent: (messages[i] as Map)["isSent"])
      );
    }

    return (
      <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              reverse: true,
              scrollDirection: Axis.vertical,
              children: messagesList,
            )
          )
        ),
        buildMessengerKeyboard()
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
            backgroundColor: Theme.of(context).primaryColor,
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
            margin: EdgeInsets.all(0),
            child: Center(
              child: Column(
                children: buildMessenger()
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
  final List<Object> messages;
  ChatMessenger({Key key, @required this.recipient, this.messages = dummyData}) : super(key: key);

  @override
  State<ChatMessenger> createState() => ChatMessengerState();

}