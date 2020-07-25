import 'package:flutter/material.dart';

import '../../../constants/profile_constants.dart';
import '../../../models/models.dart';
import '../../common/school_row.dart';
import '../../common/section.dart';

 
class ProfileEducation extends StatelessWidget {  
  final List<School> schools;

  ProfileEducation({Key key, @required this.schools}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return schools.length > 0
      ? Section(
        title: sectionTitleEducation,
        child: buildSchoolList()
      ) : SizedBox();
  }

  Widget buildSchoolList() {
    var schoolList = <Widget>[];
    for (var i = 0; i < schools.length; i++) {
      schoolList.add(
        SectionRow(children: <Widget>[SchoolRow(school: schools[i])])
      );
    }
    return SectionList(children: schoolList);
  }
}