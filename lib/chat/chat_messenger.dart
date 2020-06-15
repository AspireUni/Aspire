import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import './message.dart';

const dummyData = [
  {
    "type": 1,
    "message": "images/hellobig.jpg",
    "isSent": false,
    "timestamp": '2020-06-04 09:33'
  },
  {
    "type": 1,
    "message": "images/hello.png",
    "isSent": true,
    "timestamp": '2020-06-04 09:33'
  },
  {
    "type": 0,
    "message": "Hello",
    "isSent": true,
    "timestamp": '2020-06-04 09:36'
  },
  {
    "type": 0,
    "message": "it's me",
    "isSent": false,
    "timestamp": '2020-06-04 09:36'
  },
  {
    "type": 0,
    "message": "I was wondering if after all these years you'd like to meet",
    "isSent": true,
    "timestamp": '2020-06-04 09:37'
  },
  {
    "type": 0,
    "message": "to go over?",
    "isSent": false,
    "timestamp": '2020-06-04 09:38'
  },
  {
    "type": 0,
    "message": "everything.",
    "isSent": true,
    "timestamp": '2020-06-04 09:39'
  },
  {
    "type": 0,
    "message": "they say that time's supposed to heal ya",
    "isSent": true,
    "timestamp": '2020-06-04 09:41'
  },
  {
    "type": 0,
    "message": "but I ain't done much healing 😠",
    "isSent": true,
    "timestamp": '2020-06-04 09:42'
  },
];

class ChatMessengerState extends State<ChatMessenger> {
  String recipient;
  List<Object> messages = [...dummyData];
  // bool isLoading = false;

  File imageFile;

  final TextEditingController textInputController = new TextEditingController();
  final ImagePicker imagePicker = new ImagePicker();

  void addMessage (type, message, timestamp, isSent) {
    setState(() {messages = [...messages, {"type": type, "message": message, "isSent": isSent, "timestamp": timestamp}];});
  }

  void submitMessage (int type, String value) {
    if (value.trim() != '') {
      textInputController.clear();
      String timestamp = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.now());
      addMessage(type, value, timestamp, true);
      SystemSound.play(SystemSoundType.click);
    }
  }

  Widget buildTimestamp(String timestamp, bool isSent) {
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

  // Future uploadImage() async {
  //   String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //   StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
  //   StorageUploadTask uploadTask = reference.putFile(imageFile);
  //   StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
  //   storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
  //     String imageUrl = downloadUrl;
  //     setState(() {
  //       // isLoading = false;
  //       onSendMessage(imageUrl, 1);
  //     });
  //   }, onError: (err) {
  //     // setState(() {
  //     //   isLoading = false;
  //     // });
  //     // Fluttertoast.showToast(msg: 'This file is not an image');
  //     print("error");
  //   });
  // }

  Future pickImage(ImageSource imageSource) async {
    imageFile = (await imagePicker.getImage(source: imageSource)) as File;

    if (imageFile != null) {
      // TODO: upload to Firebase and store url to image as the "message"
      // uploadImage();
    }
  }

  Widget buildMessengerKeyboard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(width: 1.0, color: Colors.grey[100]))
      ),
      constraints: BoxConstraints(minHeight: 70.0, maxHeight: 200.0),
      padding: EdgeInsets.only(bottom: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () => pickImage(ImageSource.gallery),
          ),
          IconButton(
            icon: Icon(Icons.camera),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () => pickImage(ImageSource.camera),
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
              onSubmitted: (value) => submitMessage(0, value),
            )
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () => submitMessage(0, textInputController.value.text),
          ),
        ]
      )
    );
  }

  List<Widget> buildMessenger() {
    List<Widget> messagesList = new List<Widget>();
    for (int i = messages.length - 1; i >= 0; i--) {
      if (i == messages.length - 1) {
        messagesList.add(
          buildTimestamp((messages[i] as Map)["timestamp"], (messages[i] as Map)["isSent"])
        );
      }
      messagesList.add(
        Message(type: (messages[i] as Map)["type"], message: (messages[i] as Map)["message"], isSent: (messages[i] as Map)["isSent"])
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