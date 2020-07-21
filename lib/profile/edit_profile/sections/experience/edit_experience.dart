import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../../../../constants/profile_constants.dart';
import '../../../../models/models.dart';
import '../../../../selectors/selectors.dart';
import '../../../common/add_row_button.dart';
import '../../../common/job_row.dart';
import '../../../common/section.dart';
import '../../../common/styles.dart';
import './save_experience.dart';


class EditExperience extends StatefulWidget {  
  EditExperience({Key key}) : super(key: key);

  @override
  _EditExperienceState createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          AddRowButton(
            text: addExperienceRowText,
            onTap: handleAddTap
          ),
          StoreConnector<AppState, List<Job>>(
            converter: jobListSelector,
            builder: (context, jobs) => jobs != null 
            ? buildJobList(jobs) : SizedBox()
          )
        ]
      )
    );
  }

  Widget buildJobRow(Job job) {
    return InkWell(
      onTap: () => handleEditTap(job.id),
      child: SectionRow(
        children: <Widget> [
          JobRow(job: job),
          editButtonInRow
        ]
      )
    );
  }

  Widget buildJobList(List<Job> jobs) {
    var jobList = <Widget>[];
    for (var i = 0; i < jobs.length; i++) {
      jobList.add(
        buildJobRow(jobs[i]),
      );
    }
    return SectionList(children: jobList);
  }

  void handleAddTap() {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SaveExperience(
          editMode: false
        )
      )
    );
  }

  void handleEditTap(String jobId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SaveExperience(
          editMode: true,
          jobId: jobId
        )
      )
    );
  }

}
