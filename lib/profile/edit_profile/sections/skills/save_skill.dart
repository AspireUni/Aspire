import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';

import '../../../../constants/profile_constants.dart';
import '../../../common/app_bar.dart';
import '../../../common/delete_button.dart';
import '../../../common/input_field.dart';
import '../../../common/list_picker.dart';
import '../../../common/picker_field.dart';
import '../../../common/styles.dart';

class SaveSkill extends StatefulWidget {
  final bool editMode;
  final Map<String, Object> skillInfo;
  
  SaveSkill({Key key, @required this.editMode, this.skillInfo}) 
    : super(key: key);

  @override
  _SaveSkillState createState() => _SaveSkillState();
}

class _SaveSkillState extends State<SaveSkill> {
  final GlobalKey<FormBuilderState> _saveSkillKey 
    = GlobalKey<FormBuilderState>();
  final FocusNode skillFocus = FocusNode();
  final List<String> skills = [skillBeginner, skillIntermediate, skillExpert];
  
  bool isLevelFocused;
  Map<String, Object> skill;

  @override
  void initState() {
    super.initState();
   
    isLevelFocused = false;

    // Temporary workaround until we use global state management
    skill = {
      'skill': widget.editMode ? widget.skillInfo['skill'] : null,
      'level': widget.editMode ? widget.skillInfo['level'] : null,
    };

    textFieldFocusListener(skillFocus, 'skill');
  }

  @override
  void dispose() {
    skillFocus.dispose();
    super.dispose();
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
        _saveSkillKey.currentState.fields[attribute].currentState.validate();
      }
    });
  }

  void handleLevelConfirm(Picker picker) {
    var newLevel = picker.getSelectedValues()[0].toString();
    setState(() { 
      skill['level'] = newLevel;
    });
    _saveSkillKey.currentState.fields['level'].currentState
      .didChange(newLevel);    
    _saveSkillKey.currentState.fields['level'].currentState
      .validate();
  }

  void showLevelPicker(BuildContext context) {
    ListPicker(
      data: skills,
      selecteds: [ skill['level'] != null 
        ? skills.indexOf(skill['level']) 
        : 0 
      ],
      onConfirm: (picker, value) => handleLevelConfirm(picker)
    ).build(context).showModal(context);
  }

  Widget buildSkillField() {
    return FormBuilderTextField(
      attribute: 'skill',
      initialValue: skill['skill'],
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => setState(() { skill['skill'] = value as String; }),
      focusNode: skillFocus,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  Widget buildLevelField() {
    return PickerField(
      attribute: 'level',
      initialValue: skill['level'],
      isFocused: isLevelFocused,
      isEnabled: true,
      value: skill['level'] ?? '',
      onTap: () {
        skillFocus.unfocus();
        setState(() {
          isLevelFocused = true;
        });
        showLevelPicker(context); 
      }
    );
  }

  List<Widget> buildSaveSkillForm(context) {
    return <Widget>[
      FormBuilder(
        key: _saveSkillKey,
        child: Column(
          children: <Widget>[
            InputField(
              labelText: saveSkillSkill,
              formField: buildSkillField()
            ),
            InputField(
              labelText: saveSkillLevel,
              formField: buildLevelField()
            )
          ]
        )
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocusFields,
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBarWithSave(
              appBarTitle: widget.editMode ? editSkill : addSkill,
              data: skill,
              formKey: _saveSkillKey,
              onActionTap: unfocusFields,
            ),
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.all(20.0),
                child: ListView(
                children: <Widget>[
                  ...buildSaveSkillForm(context),
                  widget.editMode
                  ? DeleteButton(
                    labelText: deleteSkill,
                    onPressed: () => print('Skill deleted.')
                  )
                  : SizedBox()
                ]
              )
            )
          ),
        ]
      )
    );
  }
}