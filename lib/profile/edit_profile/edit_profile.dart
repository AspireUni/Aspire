import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../constants/profile_constants.dart';
import '../common/app_bar.dart';
import '../common/section.dart';
import './sections/contact/edit_contact.dart';
import './sections/education/edit_education.dart';
import './sections/experience/edit_experience.dart';
import './sections/skills/edit_skills.dart';
import './sections/summary/edit_summary.dart';

class EditProfile extends StatefulWidget {
  final Map data;
  
  EditProfile({Key key, @required this.data}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormBuilderState> _saveProfileKey 
    = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBarWithSave(
              appBarTitle: editProfile,
              formKey: _saveProfileKey
            ),
            backgroundColor: Colors.white,
            body: ListView(
              children: buildEditProfileView(context)
            )
          ),
        ]
      )
    );
  }

  List<Widget> buildEditProfileView(BuildContext context) {
    return <Widget>[
      FormBuilder(
        key: _saveProfileKey,
        child: Column(
          children: <Widget>[
            Section(
              title: editContactInfo,
              child: EditContact(
                contact: widget.data['contact'],
                fullName: widget.data['fullName']
              )
            ),
            Section(
              title: editSummary,
              child: EditSummary(
                summary: widget.data['summary']
              )
            ),
            Section(
              title: editEducation,
              child: EditEducation(
                schools: widget.data['schools']
              )
            ),
            Section(
              title: editExperience,
              child: EditExperience(
                jobs: widget.data['jobs']
              )
            ),
            Section(
              title: editSkills,
              child: EditSkills(
                skills: widget.data['skills']
              )
            )
          ]
        )
      ),
    ];
  }
}
