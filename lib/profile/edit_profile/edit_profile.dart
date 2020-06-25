import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

import '../view_profile/sections/section.dart';
import './sections/contact/edit_contact.dart';
import './sections/edit_summary.dart';
import './sections/education/edit_education.dart';
import './sections/experience/edit_experience.dart';
import './sections/skills/edit_skills.dart';

class EditProfile extends StatefulWidget {
  final Map data;
  EditProfile({Key key, @required this.data}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  ValueChanged _onChanged = (val) => print(val);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close, color: Colors.white)
            ),
            actions: <Widget>[
              Container(
                padding: EdgeInsets.only(top:17.0, right: 20.0),
                child: InkWell(
                  onTap: () {
                    if (_fbKey.currentState.saveAndValidate()) {
                      print(_fbKey.currentState.value);
                    } else {
                      print(_fbKey.currentState.value);
                      print("validation failed");
                    }
                  },
                  child: Text(
                    "Save",
                    style: GoogleFonts.muli(
                      textStyle: TextStyle(
                        color: Colors.white, 
                        letterSpacing: .5, 
                        fontSize: 15.0, 
                        fontWeight: FontWeight.bold
                      )
                    )
                  )
                )
              )
            ],
            backgroundColor: Theme.of(context).primaryColor,
            centerTitle: true,
            title: Text(
              "Edit profile",
              style: GoogleFonts.muli(
                textStyle: TextStyle(
                  color: Colors.white, 
                  letterSpacing: .5, 
                  fontSize: 20.0, 
                  fontWeight: FontWeight.bold
                )
              )
            ),
          ),
          backgroundColor: Colors.white,
          body: ListView(
            children: buildEditProfileView(context)
          )
        ),
      ]
    );
  }

  buildEditProfileView(context) {
    return <Widget>[
      FormBuilder(
        // context,
        key: _fbKey,
        // autovalidate: true,
        initialValue: {},
        readOnly: false,
        child: Column(
          children: <Widget>[
            Section(
              title: "Edit contact info",
              child: EditContact(
                contact: widget.data["contact"],
                fullName: widget.data["fullName"]
              )
            ),
            Section(
              title: "Edit summary",
              child: EditSummary(
                summary: widget.data["summary"]
              )
            ),
            Section(
              title: "Edit education",
              child: EditEducation(
                schools: widget.data["schools"]
              )
            ),
            Section(
              title: "Edit experience",
              child: EditExperience(
                jobs: widget.data["jobs"]
              )
            ),
            Section(
              title: "Edit skills",
              child: EditSkills(
                skills: widget.data["skills"]
              )
            )
          ]
        )
      ),
    ];
  }
}
