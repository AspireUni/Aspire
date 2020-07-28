import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../../constants/profile_constants.dart';
import '../../../../models/models.dart';
import '../../../../selectors/selectors.dart';
import '../../../common/add_row_button.dart';
import '../../../common/school_row.dart';
import '../../../common/section.dart';
import '../../../common/styles.dart';
import './education_item.dart';


class SaveEducation extends StatefulWidget {
  SaveEducation({Key key}) : super(key: key);

  @override
  _SaveEducationState createState() => _SaveEducationState();
}

class _SaveEducationState extends State<SaveEducation> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          AddRowButton(
            text: addEducationRowText,
            onTap: handleAddTap
          ),
          StoreConnector<AppState, List<School>>(
            converter: schoolListSelector,
            builder: (context, schools) => schools != null 
            ? buildSchoolList(schools) : SizedBox()
          )
        ]
      )
    );
  }
  
  Widget buildSchoolRow(School school) {
    return InkWell(
      onTap: () => handleEditTap(school.id),
      child: SectionRow(
        children: <Widget> [
          SchoolRow(school: school),
          editButtonInRow
        ]
      )
    );
  }

  Widget buildSchoolList(List<School> schools) {
    var schoolList = <Widget>[];
    for (var i = 0; i < schools.length; i++) {
      schoolList.add(buildSchoolRow(schools[i]));
    }
    return SectionList(children: schoolList);
  }
  
  void handleAddTap() {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SaveEducationItem(
          editMode: false
        )
      )
    );
  }

  void handleEditTap(String schoolId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SaveEducationItem(
          editMode: true,
          schoolId: schoolId
        )
      )
    );
  }
}
