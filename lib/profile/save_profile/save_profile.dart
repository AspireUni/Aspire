import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../actions/actions.dart';
import '../../constants/common_constants.dart';
import '../../constants/profile_constants.dart';
import '../../helpers/user_entity_helper.dart';
import '../../models/models.dart';
import '../../navigation/app_controller.dart';
import '../../services/services.dart';
import '../common/app_bar.dart';
import '../common/section.dart';
import './sections/contact/save_contact.dart';
import './sections/education/education.dart';
import './sections/experience/experience.dart';
import './sections/skills/skills.dart';
import './sections/summary/summary.dart';


class SaveProfile extends StatefulWidget {
  final bool editMode;
  final GlobalKey<FormBuilderState> formKey;


  SaveProfile({
    Key key, 
    @required this.editMode, 
    @required this.formKey
  }) : super(key: key);

  @override
  _SaveProfileState createState() => _SaveProfileState();
}

class _SaveProfileState extends State<SaveProfile> {
  Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    return GestureDetector(
      onTap: () {
        var currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBarWithSave(
          appBarTitle: widget.editMode ? editProfile : buildProfile,
          closeActionEnabled: widget.editMode,
          formKey: widget.formKey,
          onSaveActionTap: () => handleSaveProfile(context),
          onCloseActionTap: handleClose,
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
        key: widget.formKey,
        child: Column(
          children: <Widget>[
            Section(
              title: sectionTitleContact,
              child: SaveContact()
            ),
            Section(
              title: sectionTitleSummary,
              child: SaveSummary()
            ),
            Section(
              title: sectionTitleEducation,
              child: SaveEducation()
            ),
            Section(
              title: sectionTitleExperience,
              child: SaveExperience()
            ),
            Section(
              title: sectionTitleSkills,
              child: SaveSkills()
            )
          ]
        )
      ),
    ];
  }

  void handleSaveProfile(BuildContext context) async {
    var userJson;
    store.dispatch(UpdateIsFtu(payload: false));
    userJson = await convertProfileStateToUserEntity(store);
    await updateUser(userJson);
    if (widget.editMode) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AppController(
            tabIndex: 0
          )
        )
      );
    } else {
      store.dispatch(UpdateAuthStatus(AuthStatus.loggedIn));
    }
    
  }

  void handleClose() {
    store.dispatch(UpdateSaveProfileState(SaveProfileState.initial()));
  }
}