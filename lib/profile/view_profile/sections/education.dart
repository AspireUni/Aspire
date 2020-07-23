import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../constants/profile_constants.dart';
import '../../../models/models.dart';
import '../../../selectors/selectors.dart';
import '../../common/school_row.dart';
import '../../common/section.dart';

 
class ProfileEducation extends StatelessWidget {  
  ProfileEducation({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<School>>(
      converter: schoolListSelector,
      builder: (context, schools) => schools != null 
      ? Section(
        title: sectionTitleEducation,
        child: buildSchoolList(schools)
      ) : SizedBox()
    );
  }

  Widget buildSchoolList(List<School> schools) {
    var schoolList = <Widget>[];
    for (var i = 0; i < schools.length; i++) {
      schoolList.add(
        SectionRow(children: <Widget>[SchoolRow(school: schools[i])])
      );
    }
    return SectionList(children: schoolList);
  }
}