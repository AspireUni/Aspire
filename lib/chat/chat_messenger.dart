import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../constants/chat_constants.dart';
import '../services/user_service.dart';
import './message.dart';

class ChatMessengerState extends State<ChatMessenger> {
  String id;
  String peerId;
  String recipient;

  String groupChatId;
  File imageFile;
  String imageUrl;

  final TextEditingController textInputController = TextEditingController();
  final ImagePicker imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    groupChatId = 'testtsteta';
    imageUrl = '';
  }

  void submitMessage (int type, String content) {
    if (content.trim() != '') {
      textInputController.clear();
      addMessage(id, peerId, content, type, groupChatId);
      SystemSound.play(SystemSoundType.click);
    }
  }

  Widget buildTimestamp(int timestamp, {bool isSent}) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child:  Container(
        margin: isSent 
          ? EdgeInsets.fromLTRB(50.0, 0.0, 10.0, 10.0) 
          : EdgeInsets.fromLTRB(10.0, 10.0, 50.0, 10.0),
        child: Text (
          DateFormat('jm').format(
            DateTime.fromMillisecondsSinceEpoch(timestamp)
          ),
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

  Future uploadImage() async {
    var fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var reference = FirebaseStorage.instance.ref().child(fileName);
    var uploadTask = reference.putFile(imageFile);
    var storageTaskSnapshot = await uploadTask.onComplete;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl as String;
      submitMessage(imageMessage, imageUrl);
    }, onError: (err) {
      print("error");
    });
  }

  Future pickImage(ImageSource imageSource) async {
    var pickedFile = await imagePicker.getImage(source: imageSource);
    imageFile = File(pickedFile.path);

    if (imageFile != null) {
      uploadImage();
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
              onSubmitted: (value) => submitMessage(textMessage, value),
            )
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () => submitMessage(
              textMessage, textInputController.value.text
            ),
          ),
        ]
      )
    );
  }

  List<Widget> buildMessage(int index, int maxItem, DocumentSnapshot document) {
    var isSent = document['idFrom'] == id;
    var widgets = <Widget>[];
    widgets.add(
      Message(
        isSent: isSent,
        message: document['content'],
        type: document['type']
      )
    );
    if (index == 0) {
      widgets.add(
        buildTimestamp(int.parse(document['timestamp']), isSent: isSent)
      );
    }
    return widgets;
  }

  List<Widget> buildMessenger() {
    return (
      <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: StreamBuilder(
              stream: Firestore.instance
                .collection('messages')
                .document(groupChatId)
                .collection(groupChatId)
                .orderBy('timestamp', descending: true)
                .limit(20)
                .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("wait");
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) => Column(
                      children: buildMessage(
                        index,
                        snapshot.data.documents.length,
                        snapshot.data.documents[index]
                      )
                    ),
                    itemCount: snapshot.data.documents.length,
                    reverse: true,
                    scrollDirection: Axis.vertical,
                  );
                }
              }
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
  final String peerId;
  final String recipient;
  ChatMessenger({Key key, @required this.peerId, @required this.recipient})
    : super(key: key);

  @override
  State<ChatMessenger> createState() => ChatMessengerState();

}