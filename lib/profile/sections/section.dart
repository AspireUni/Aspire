import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
 
class Section extends StatelessWidget {  
  final String title;
  final Widget child;
  Section({Key key, @required this.title, @required this.child}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    final ThemeData sectionTheme = Theme.of(context).copyWith(
      dividerColor: Colors.transparent,
      accentColor: Colors.black38,
      unselectedWidgetColor: Colors.black38
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(30.0, 0, 30.0 ,0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 5.0,
            color: Colors.black12
          )
        )
      ),
      child: Theme(
        data: sectionTheme,
        child: ListTileTheme(
          dense: true,
          contentPadding: EdgeInsets.all(0),
          child: ExpansionTile(
            initiallyExpanded: true,
            title: buildHeader(),
            children: <Widget>[
              child
            ],
          )
        )
      )
    );
  }

  buildHeader(){
    return Container(
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: GoogleFonts.muli(
          textStyle: TextStyle(
            color: Colors.black, 
            letterSpacing: .5, 
            fontSize: 18.0, 
            fontWeight: FontWeight.w600,
          ),
        )
      )
    );
  }
}

class SectionRow extends StatelessWidget {  
  final List<Widget> children;
  SectionRow({Key key, @required this.children}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(bottom: 10.0),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12
          )
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children
      )
    );
  }
}


class SectionList extends StatelessWidget {  
  final List<Widget> children;
  SectionList({Key key, @required this.children}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children
      )
    );
  }
}
