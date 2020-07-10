import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/profile_constants.dart';
import '../../../common/add_row_button.dart';
import '../../../common/school_row.dart';
import '../../../common/section.dart';
import '../../../common/styles.dart';
import './save_education.dart';


class EditEducation extends StatefulWidget {
  final List<Map<String, Object>> schools;
  EditEducation({Key key, @required this.schools}) : super(key: key);

  @override
  _EditEducationState createState() => _EditEducationState();
}

class _EditEducationState extends State<EditEducation> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          AddRowButton(
            text: addEducationRowText,
            onTap: () => handleAddTap(context)
          ),
          buildSchoolList(context)
        ]
      )
    );
  }
  
  Widget buildSchoolRow(BuildContext context, Map<String, Object> schoolInfo) {
    return InkWell(
      onTap: () => handleEditTap(context, schoolInfo),
      child: SectionRow(
        children: <Widget> [
          SchoolRow(schoolInfo: schoolInfo),
          editButtonInRow
        ]
      )
    );
  }

  Widget buildSchoolList(BuildContext context) {
    var schoolList = [];
    for (var i = 0; i < widget.schools.length; i++) {
      schoolList.add(
        buildSchoolRow(
          context, 
          widget.schools[i]
        )
      );
    }
    return SectionList(children: schoolList);
  }
  
  void handleAddTap(BuildContext context) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SaveEducation(
          editMode: false
        )
      )
    );
  }

  void handleEditTap(BuildContext context, Map<String, Object> schoolInfo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SaveEducation(
          editMode: true,
          schoolInfo: schoolInfo
        )
      )
    );
  }
}
