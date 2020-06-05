import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
 
class ProfileIconButton extends StatelessWidget {
  final IconData name;
  final String caption;
  ProfileIconButton({Key key, @required this.name, @required this.caption}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 2.0),
            child: Material(
              color: Colors.transparent,
              child: Center(
                widthFactor: 1,
                heightFactor: 1,
                child: Ink(
                  width: 24.0,
                  height: 24.0,
                  decoration: ShapeDecoration(
                    color: Color(0xFF45cab9),
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(name, size: 15.0),
                    padding: EdgeInsets.all(0.0),
                    color: Colors.white,
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ),
          Text(
            caption,
            style: GoogleFonts.muli(
              textStyle: TextStyle(
                color: Colors.grey,
                letterSpacing: .5,
                fontSize: 10,
                fontWeight: FontWeight.w600
              )
            )
          )
        ]
      )
    );
  }
}