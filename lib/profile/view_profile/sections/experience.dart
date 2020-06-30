import 'package:flutter/material.dart';

import '../../../constants/profile_constants.dart';
import '../../common/job_row.dart';
import '../../common/section.dart';
 
class ProfileExperience extends StatelessWidget {  
  final List<Map<String, Object>> jobs;
  ProfileExperience({Key key, @required this.jobs}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Section(
      title: sectionTitleExperience,
      child: buildJobList(context)
    );
  }

  Widget buildJobList(BuildContext context) {
    List<Widget> jobList = <Widget>[];
    for (int i = 0; i < jobs.length; i++) {
      jobList.add(
        SectionRow(children: <Widget>[JobRow(jobInfo: jobs[i])])
      );
    }
    return SectionList(children: jobList);
  }
}