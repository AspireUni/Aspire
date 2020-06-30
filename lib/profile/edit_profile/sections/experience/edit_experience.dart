import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/profile_constants.dart';
import '../../../common/add_row_button.dart';
import '../../../common/job_row.dart';
import '../../../common/section.dart';
import '../../../common/styles.dart';
import './save_experience.dart';


class EditExperience extends StatefulWidget {
  final List<Map<String, Object>> jobs;
  
  EditExperience({Key key, @required this.jobs}) : super(key: key);

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
            onTap: () => handleAddTap(context)
          ),
          buildJobList(context)
        ]
      )
    );
  }

  Widget buildJobRow(BuildContext context, Map<String, Object> jobInfo) {
    return InkWell(
      onTap: () => handleEditTap(context, jobInfo),
      child: SectionRow(
        children: <Widget> [
          JobRow(jobInfo: jobInfo),
          editButtonInRow
        ]
      )
    );
  }

  Widget buildJobList(BuildContext context) {
    List<Widget> jobList = [];
    for (int i = 0; i < widget.jobs.length; i++) {
      jobList.add(
        buildJobRow(
          context, 
          widget.jobs[i]
        ),
      );
    }
    return SectionList(children: jobList);
  }

  void handleAddTap(BuildContext context) {
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => SaveExperience(
          editMode: false
        )
      )
    );
  }

  void handleEditTap(BuildContext context, Map<String, Object> jobInfo) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SaveExperience(
          editMode: true,
          jobInfo: jobInfo
        )
      )
    );
  }

}
