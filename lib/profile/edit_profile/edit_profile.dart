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
  EditProfile({Key key}) : super(key: key);

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
      child: Scaffold(
        appBar: AppBarWithSave(
          appBarTitle: editProfile,
          formKey: _saveProfileKey
        ),
        backgroundColor: Colors.white,
        body: ListView(
          children: buildEditProfileView()
        )
      )
    );
  }

  List<Widget> buildEditProfileView() {
    return <Widget>[
      FormBuilder(
        key: _saveProfileKey,
        child: Column(
          children: <Widget>[
            Section(
              title: editContactInfo,
              child: EditContact()
            ),
            Section(
              title: editSummary,
              child: EditSummary()
            ),
            Section(
              title: editEducation,
              child: EditEducation()
            ),
            Section(
              title: editExperience,
              child: EditExperience()
            ),
            Section(
              title: editSkills,
              child: EditSkills()
            )
          ]
        )
      ),
    ];
  }
}
