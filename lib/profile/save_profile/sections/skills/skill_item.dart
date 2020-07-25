import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:random_string/random_string.dart';
import 'package:redux/redux.dart';

import '../../../../actions/actions.dart';
import '../../../../constants/profile_constants.dart';
import '../../../../models/models.dart';
import '../../../../selectors/selectors.dart';
import '../../../common/app_bar.dart';
import '../../../common/delete_button.dart';
import '../../../common/input_field.dart';
import '../../../common/list_picker.dart';
import '../../../common/picker_field.dart';
import '../../../common/styles.dart';

class SaveSkillItem extends StatefulWidget {
  final bool editMode;
  final String skillId;
  
  SaveSkillItem({Key key, @required this.editMode, this.skillId}) 
    : super(key: key);

  @override
  _SaveSkillItemState createState() => _SaveSkillItemState();
}

class _SaveSkillItemState extends State<SaveSkillItem> {
  final GlobalKey<FormBuilderState> _saveSkillItemKey 
    = GlobalKey<FormBuilderState>();
  final FocusNode skillFocus = FocusNode();
  final List<String> skills = [skillBeginner, skillIntermediate, skillExpert];
  
  bool isLevelFocused, isActive;
  Store<AppState> store; 
  String generatedId;

  @override
  void initState() {
    super.initState();
   
    isLevelFocused = false;
    isActive = true;

    textFieldFocusListener(skillFocus, 'skill');

    if (!widget.editMode) {
      generatedId = randomAlphaNumeric(15);
    }
  }

  @override
  void dispose() {
    skillFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    return GestureDetector(
      onTap: unfocusFields,
      child: Scaffold(
        appBar: AppBarWithSave(
          appBarTitle: widget.editMode ? editSkill : addSkill,
          formKey: _saveSkillItemKey,
          closeActionEnabled: true,
          onCloseActionTap: handleClose,
          onSaveActionTap: handleSaveSkill,
        ),
        backgroundColor: Colors.white,
        body: StoreConnector<AppState, Skill>(
          converter: (store) => saveSkillStateSelector(
            store,
            id: widget.skillId ?? generatedId,
            editMode: widget.editMode,
            isPageActive: isActive
          ),
          builder: (context, skill) => Container(
            padding: EdgeInsets.all(20.0),
              child: ListView(
              children: <Widget>[
                ...buildSaveSkillForm(skill),
                widget.editMode
                ? DeleteButton(
                  labelText: deleteSkill,
                  onPressed: handleDeleteSkill
                )
                : SizedBox()
              ]
            )
          )
        )
      )
    );
  }

  void unfocusFields() {
    skillFocus.unfocus();
    unfocusLevelField();
  }

  void unfocusLevelField() {
    setState(() {
      isLevelFocused = false;
    });
  }

  void textFieldFocusListener(FocusNode focus, String attribute) {
    focus.addListener(() {
      if (focus.hasFocus) {
        unfocusLevelField();
      } else {
        _saveSkillItemKey
          .currentState
          .fields[attribute]
          .currentState
          .validate();
      }
    });
  }

  void handleSaveSkill() {
    if (widget.editMode) {
      store.dispatch(UpdateSkill());
    } else {
      store.dispatch(AddSkill());
    }
    setState(() { isActive = false; });
    unfocusFields();
    Navigator.pop(context);
  }

  void handleDeleteSkill() {
    store.dispatch(DeleteSkill());
    setState(() { isActive = false; });
    unfocusFields();
    Navigator.pop(context);
  }

  void handleClose() {
    store.dispatch(UpdateSaveSkillState(Skill.initial()));
    setState(() { isActive = false; });
  }

  void handleLevelConfirm(Picker picker, Skill skill) {
    var newLevel = picker.getSelectedValues()[0].toString();
    store.dispatch(
      UpdateSaveSkillState(
        skill.copyWith(
          level: newLevel
        )
      )
    );
    _saveSkillItemKey.currentState.fields['level'].currentState
      .didChange(newLevel);    
    _saveSkillItemKey.currentState.fields['level'].currentState
      .validate();
  }

  void showLevelPicker(Skill skill) {
    ListPicker(
      data: skills,
      selecteds: [ skill.level != null 
        ? skills.indexOf(skill.level) 
        : 0 
      ],
      onConfirm: (picker, value) => handleLevelConfirm(picker, skill)
    ).build(context).showModal(context);
  }

  Widget buildSkillField(Skill skill) {
    return FormBuilderTextField(
      attribute: 'skill',
      initialValue: skill.name,
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => store.dispatch(
        UpdateSaveSkillState(
          skill.copyWith(
            name: value
          )
        )
      ),
      focusNode: skillFocus,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  Widget buildLevelField(Skill skill) {
    return PickerField(
      attribute: 'level',
      initialValue: skill.level,
      isFocused: isLevelFocused,
      isEnabled: true,
      value: skill.level ?? '',
      onTap: () {
        skillFocus.unfocus();
        setState(() {
          isLevelFocused = true;
        });
        showLevelPicker(skill); 
      }
    );
  }

  List<Widget> buildSaveSkillForm(Skill skill) {
    return <Widget>[
      FormBuilder(
        key: _saveSkillItemKey,
        child: Column(
          children: <Widget>[
            InputField(
              labelText: saveSkillSkill,
              formField: buildSkillField(skill)
            ),
            InputField(
              labelText: saveSkillLevel,
              formField: buildLevelField(skill)
            )
          ]
        )
      ),
    ];
  }
}