import 'package:bubble/bubble.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../common/common.dart';
import '../constants/chat_constants.dart';

class MessageView extends StatelessWidget {
  final int type;
  final String message;
  final bool isSent;
  MessageView(
    {Key key, @required this.message, @required this.isSent, this.type}
  ) : super(key: key);

  Widget buildTextMessageBubble(BuildContext context) {
    var nip = isSent ? BubbleNip.rightTop : BubbleNip.leftTop;
    var margin = isSent ? 
      BubbleEdges.fromLTRB(50.0, 10.0, 10.0, 10.0) :
      BubbleEdges.fromLTRB(10.0, 10.0, 50.0, 10.0);
    var color = isSent ? Theme.of(context).accentColor : Colors.grey;
    return Bubble(
      nip: nip,
      nipOffset: 0.0,
      style: BubbleStyle(
        margin: margin,
        padding: BubbleEdges.all(10.0),
        color: color,
      ),
      child: FormatText(
        text: message,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      )
    );
  }

  Widget buildImageMessageBubble(BuildContext context) {
    var nip = isSent ? BubbleNip.rightTop : BubbleNip.leftTop;
    var margin = isSent ? 
      BubbleEdges.fromLTRB(50.0, 10.0, 10.0, 10.0) :
      BubbleEdges.fromLTRB(10.0, 10.0, 50.0, 10.0);
    var color = isSent ? Theme.of(context).accentColor : Colors.grey;
    return Bubble(
      nip: nip,
      nipOffset: 0.0,
      style: BubbleStyle(
        margin: margin,
        padding: BubbleEdges.all(10.0),
        color: color,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: CachedNetworkImage(
          imageUrl: message,
          fit: BoxFit.fill,
          placeholder: (context, url) => Container(
            width: 200.0,
            height: 200.0,
            padding: EdgeInsets.all(70.0),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)
            )
          ),
          errorWidget: (context, url, error) => Text("error"),
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    var alignment = isSent ? Alignment.centerRight : Alignment.centerLeft;
    return Align(
      alignment: alignment,
      child: type == textMessage ? 
        buildTextMessageBubble(context) : 
        buildImageMessageBubble(context)
    );
  }
}