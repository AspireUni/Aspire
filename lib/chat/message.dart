import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final int type;
  final String message;
  final bool isSent;
  Message({Key key, @required this.type, @required this.message, @required this.isSent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: type == 0 ? Container(
        decoration: BoxDecoration(
          color: isSent ? Theme.of(context).accentColor : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        margin: isSent ? EdgeInsets.fromLTRB(50.0, 10.0, 10.0, 10.0) : EdgeInsets.fromLTRB(10.0, 10.0, 50.0, 10.0),
        padding: EdgeInsets.all(10.0),
        child: Text(
          message,
          style: GoogleFonts.muli(
            textStyle: TextStyle(
              color: Colors.white, 
              letterSpacing: .5, 
              fontSize: 14.0, 
            )
          )
        )
      ) : Container(
        decoration: BoxDecoration(
          color: isSent ? Theme.of(context).accentColor : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        margin: isSent ? EdgeInsets.fromLTRB(50.0, 10.0, 10.0, 10.0) : EdgeInsets.fromLTRB(10.0, 10.0, 50.0, 10.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: CachedNetworkImage(
            imageUrl: message,
            // image: AssetImage(message),
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
      )
    );
  }
}