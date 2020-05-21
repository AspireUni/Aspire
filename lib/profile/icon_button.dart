import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
 
class ProfileIconButton extends StatelessWidget {
  final IconData name;
  final String caption;
  final void Function(String value) onPressed;
  final String activeSection;

  ProfileIconButton({
    Key key, 
    @required this.name,
    @required this.caption,
    @required this.onPressed,
    @required this.activeSection
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    bool isIconActive = activeSection == caption; 

    return Container(
      margin: const EdgeInsets.fromLTRB(10.0, 0.0 , 10.0, 0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 2.0),
            child: Material(
              color: Colors.transparent,
              child: Center(
                widthFactor: 1,
                heightFactor: 1,
                child: Ink(
                  width: 24.0,
                  height: 24.0,
                  decoration: ShapeDecoration(
                    color: isIconActive ? Color(0xFF45CAB9) :  Colors.white,
                    shape: CircleBorder(
                      side: BorderSide(
                        width: 2.0, 
                        color: Color(0xFF45CAB9)
                      )
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(name, size: 15.0),
                    padding: const EdgeInsets.all(0.0),
                    color: isIconActive ? Colors.white : Color(0xFF45CAB9),
                    onPressed: () {
                      onPressed(caption);
                    },
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