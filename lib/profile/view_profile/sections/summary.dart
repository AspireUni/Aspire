import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/profile_constants.dart';
import '../../../models/models.dart';
import '../../../selectors/selectors.dart';
import '../../common/section.dart';
 
class ProfileSummary extends StatelessWidget {  
  ProfileSummary({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, User>(
      converter: userSelector,
      builder: (context, user) => user.summary != null 
      ? Section(
        title: sectionTitleSummary,
        child: buildSummary(user.summary)
      ) : SizedBox()
    );
  }

  buildSummary(String summary) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            summary,
            textAlign: TextAlign.left,
            style: GoogleFonts.muli(
              textStyle: TextStyle(
                color: Colors.black54,
                letterSpacing: .5,
                height: 1.5,
                fontSize: 13.0,
                fontWeight: FontWeight.w600
              ),
            )
          )
        ]
      )
    );
  }
}