import 'package:flutter/material.dart';

import '../../../constants/profile_constants.dart';
import '../../common/school_row.dart';
import '../../common/section.dart';

 
class ProfileEducation extends StatelessWidget {  
  final List<Map<String, Object>> schools;
  ProfileEducation({Key key, @required this.schools}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Section(
      title: sectionTitleEducation,
      child: buildSchoolList(context)
    );
  }

  Widget buildSchoolList(BuildContext context) {
    List<Widget> schoolList = <Widget>[];
    for (int i = 0; i < schools.length; i++) {
      schoolList.add(
        SectionRow(children: <Widget>[SchoolRow(schoolInfo: schools[i])])
      );
    }
    return SectionList(children: schoolList);
  }
}