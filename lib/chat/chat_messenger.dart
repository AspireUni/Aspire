import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';

import '../common/common.dart';
import '../constants/chat_constants.dart';
import '../models/models.dart';
import '../profile/view_profile/user_profile.dart';
import '../services/services.dart';
import './common/profile_picture.dart';
import './message.dart';

class ChatMessenger extends StatefulWidget {
  final String senderId;
  final User recipient;
  final String groupChatId;
  ChatMessenger({
    Key key,
    @required this.senderId, 
    @required this.recipient,
    @required this.groupChatId,
  }) : super(key: key);

  @override
  State<ChatMessenger> createState() => ChatMessengerState();

}

class ChatMessengerState extends State<ChatMessenger> {

  Store<AppState> store;

  List<DocumentSnapshot> _messagesSnapshots;
  bool _isLoading = false;
  Message lastMessage;

  File imageFile;
  String imageUrl;

  final TextEditingController textInputController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ImagePicker imagePicker = ImagePicker();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    imageUrl = '';

    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        var message = Message.fromJson(
          _messagesSnapshots[_messagesSnapshots.length - 1]
        );
        getMessagesOlderThanTimestamp(widget.groupChatId, message.timestamp)
          .then((snapshot) {
            setState(() {
              loadNewMessages();
              _messagesSnapshots.addAll(snapshot.documents);
            });
          });
      }
    });
  }

  loadNewMessages() {
    _isLoading = true;
    getMessageSnapshots(widget.groupChatId, 1)
      .listen((onData) {
        if (onData.documents[0] != null) {
          var result = Message.fromJson(onData.documents[0]);
          if (lastMessage.toString() != result.toString()) {
            setState(() {
              _isLoading = false;
            });
          }
        }
      });
  }

  void submitMessage (int type, String content) {
    if (content.trim() != '') {
      textInputController.clear();
      var message = Message(
        idTo: widget.recipient.id,
        idFrom: widget.senderId,
        content: content,
        type: type,
        timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
        isRead: false,
      );
      addMessage(message, widget.groupChatId);
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

  IconButton buildKeyboardIconButton(Icon icon, Function onPressed) {
    return IconButton(
      icon: icon,
      iconSize: 24.0,
      padding: EdgeInsets.all(0.0),
      color: ThemeColors.accent,
      onPressed: onPressed,
    );
  }

  Widget buildKeyboardTextInput() {
    return Expanded(
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration.collapsed(
          hintText: keyboardInputHintText,
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
    );
  }

  Widget buildMessengerKeyboard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      constraints: BoxConstraints(minHeight: 50.0, maxHeight: 200.0),
      padding: EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.0, color: Colors.grey[300]),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  buildKeyboardIconButton(
                    Icon(Icons.photo), 
                    () => pickImage(ImageSource.gallery)
                  ),
                  buildKeyboardIconButton(
                    Icon(Icons.camera_alt), 
                    () => pickImage(ImageSource.camera)
                  ),
                  buildKeyboardTextInput(),
                ]
              )
            )
          ),
          buildKeyboardIconButton(
            Icon(Icons.send), 
            () => submitMessage(
              textMessage, textInputController.value.text
            )
          ),
        ]
      )
    );
  }

  List<Widget> buildMessage(int index, int maxItem, DocumentSnapshot document) {
    var isSent = document['idFrom'] == widget.senderId;
    var widgets = <Widget>[];
    widgets.add(
      MessageView(
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
              stream: _isLoading ?
                null : 
                getMessageSnapshots(widget.groupChatId, 20),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text("wait");
                } else {
                  _messagesSnapshots = snapshot
                    .data
                    .documents as List<DocumentSnapshot>;
                  lastMessage = Message.fromJson(_messagesSnapshots[0]);
                  return ListView.builder(
                    controller: scrollController,
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

  Widget buildAppBarTitle() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserProfile(
              profileId: widget.recipient.id, 
              matchId: widget.groupChatId
            )
          )
        );
      },
      child: Column (
        children: <Widget>[
          ProfilePicture(
            containerSideLength: 35.0, 
            profilePictureRadius: 35.0
          ),
          FormatText(
            text: widget.recipient.fullName,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            // remove bottom shadow
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: ThemeColors.accent
              )
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: buildAppBarTitle()
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