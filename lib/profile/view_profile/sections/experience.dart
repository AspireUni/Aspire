import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../constants/profile_constants.dart';
import '../../../models/models.dart';
import '../../../selectors/selectors.dart';
import '../../common/job_row.dart';
import '../../common/section.dart';
 
class ProfileExperience extends StatelessWidget {  
  ProfileExperience({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<Job>>(
      converter: jobListSelector,
      builder: (context, jobs) => jobs != null 
      ? Section(
        title: sectionTitleExperience,
        child: buildJobList(jobs)
      ) : SizedBox()
    );
  }

  Widget buildJobList(List<Job> jobs) {
    var jobList = <Widget>[];
    for (var i = 0; i < jobs.length; i++) {
      jobList.add(
        SectionRow(children: <Widget>[JobRow(job: jobs[i])])
      );
    }
    return SectionList(children: jobList);
  }
}