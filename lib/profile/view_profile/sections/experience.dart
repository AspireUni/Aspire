import 'package:flutter/material.dart';

import '../../../constants/profile_constants.dart';
import '../../../models/models.dart';
import '../../common/job_row.dart';
import '../../common/section.dart';
 
class ProfileExperience extends StatelessWidget {
  final List<Job> jobs;
  ProfileExperience({Key key, @required this.jobs}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return jobs.length > 0 
      ? Section(
        title: sectionTitleExperience,
        child: buildJobList()
      ) : SizedBox();
  }

  Widget buildJobList() {
    var jobList = <Widget>[];
    for (var i = 0; i < jobs.length; i++) {
      jobList.add(
        SectionRow(children: <Widget>[JobRow(job: jobs[i])])
      );
    }
    return SectionList(children: jobList);
  }
}