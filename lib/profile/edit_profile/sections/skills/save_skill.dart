import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/profile_constants.dart';
import '../input_field.dart';

class SaveSkill extends StatefulWidget {
  final bool editMode;
  final Map<String, Object> skillInfo;
  SaveSkill({Key key, @required this.editMode, this.skillInfo}) : super(key: key);

  @override
  _SaveSkillState createState() => _SaveSkillState();
}

class _SaveSkillState extends State<SaveSkill> {
  final GlobalKey<FormBuilderState> _saveSkillKey = GlobalKey<FormBuilderState>();
  final FocusNode skillFocus = FocusNode();

  final skills = [skillBeginner, skillIntermediate, skillExpert];
  
  bool isLevelFocused;
  Map<String, Object> skill;

  @override
  void initState() {
    super.initState();
   
    isLevelFocused = false;

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
    unfocusDateRangeFields();
  }


  void unfocusDateRangeFields() {
    setState(() {
      isLevelFocused = false;
    });
  }

  void textFieldFocusListener(FocusNode focus, String attribute) {
    focus.addListener(() {
      if (focus.hasFocus) {
        unfocusDateRangeFields();
      } else {
        _saveSkillKey.currentState.fields[attribute].currentState.validate();
      }
    });
  }


  void onLevelConfirm(Picker picker) {
    String newLevel = picker.getSelectedValues()[0].toString();
    setState(() { 
      skill['level'] = newLevel;
    });
    _saveSkillKey.currentState.fields['level'].currentState.didChange(newLevel);    
    _saveSkillKey.currentState.fields['level'].currentState.validate();
  }

  showLevelPicker(BuildContext context) {
    Picker(
      adapter: PickerDataAdapter(data: [
          PickerItem(
            text: Text(
              skillBeginner,
              style:GoogleFonts.muli(
                textStyle: TextStyle(
                  color: Colors.black, 
                  letterSpacing: .5, 
                  fontSize: 15.0, 
                )
              )
            ),
            value: skillBeginner
          ),
          PickerItem(
            text: Text(
              skillIntermediate,
              style:GoogleFonts.muli(
                textStyle: TextStyle(
                  color: Colors.black, 
                  letterSpacing: .5, 
                  fontSize: 15.0, 
                )
              )
            ),
            value: skillIntermediate
          ),
          PickerItem(
            text: Text(
              skillExpert,
              style:GoogleFonts.muli(
                textStyle: TextStyle(
                  color: Colors.black, 
                  letterSpacing: .5, 
                  fontSize: 15.0, 
                )
              )
            ),
            value: skillExpert
          )
        ]),
      selecteds: [ skill['level'] != null ? skills.indexOf(skill['level']) : 0 ],
      hideHeader: false,
      height: MediaQuery.of(context).size.height * 0.20,
      itemExtent: 30.0,
      magnification: 1.5,
      squeeze: 0.80,
      diameterRatio: 4.0,
      textStyle: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.black, 
          letterSpacing: .5, 
          fontSize: 15.0, 
        )
      ),
      selectedTextStyle: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      cancelTextStyle: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.red, 
          letterSpacing: .5, 
          fontSize: 15.0,
          fontWeight: FontWeight.w600 
        )
      ),
      confirmTextStyle: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.black, 
          letterSpacing: .5, 
          fontSize: 15.0,
          fontWeight: FontWeight.w600 
        )
      ),
      onConfirm: (picker, value) => onLevelConfirm(picker)
    ).showModal(context);
  }
  

  List<Widget> buildSaveSkillView(context) {
    return <Widget>[
      FormBuilder(
        key: _saveSkillKey,
        child: Column(
          children: <Widget>[
            InputField(
              labelText: 'Skill',
              formField: buildSkillField()
            ),
            buildDateRangeFields()
          ]
        )
      ),
    ];
  }

  Widget buildDeleteButton() {
    return widget.editMode 
      ? Container(
        padding: EdgeInsets.only(top: 20.0),
        child: MaterialButton(
          onPressed: () => print('Skill deleted'),
          color: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: Text(
            'Delete skill',
            style: GoogleFonts.muli(
              textStyle: TextStyle(
                color: Colors.white, 
                letterSpacing: .5, 
                fontSize: 13.0,
                fontWeight: FontWeight.w700 
              )
            )
          )
        )
      )
      : Container();
  }

  Widget buildSkillField() {
    return FormBuilderTextField(
      attribute: 'skill',
      initialValue: skill['skill'],
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0)
      ),
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.black, 
          letterSpacing: .5, 
          fontSize: 13.0, 
        )
      ),
      onChanged: (value) => setState(() { skill['skill'] = value as String; }),
      focusNode: skillFocus,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  Widget buildDateRangeFields() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 10.0),
            child: InputField(
              labelText: 'Level',
              formField: buildLevelField(),
            )
          )
        )
      ]
    );
  }

  Widget buildLevelField() {
    return buildYearField(
      attribute: 'level',
      initialValue: skill['level'],
      isFocused: isLevelFocused,
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

  Widget buildYearField({
    String attribute,
    String initialValue,
    bool isFocused,
    String value,
    void Function() onTap
  }) {
    return FormBuilderCustomField(
      attribute: attribute,
      initialValue: initialValue,
      validators: [
        FormBuilderValidators.required(),
      ],
      formField: FormField(
        builder: (field) {
          return InputDecorator(
            isFocused: isFocused,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.only(top: 5.0, bottom: 5.0),
              errorText: field.errorText
            ),
            baseStyle: GoogleFonts.muli(
              textStyle: TextStyle(
                color: Colors.black, 
                letterSpacing: .5, 
                fontSize: 13.0, 
              )
            ),
            child: Container(
              height: 20.0,
              child: InkWell(
                child: Text(
                  value,
                  style: GoogleFonts.muli(
                    textStyle: TextStyle(
                      color: Colors.black, 
                      letterSpacing: .5, 
                      fontSize: 13.0, 
                    )
                  ),
                ),
                onTap: onTap
              )
            ),
          );
        }
      )
    );
  }



  Picker buildYearPicker(BuildContext context, NumberPickerColumn pickerColumn, void Function(Picker, List<int>) onConfirm) {
    return Picker(
      adapter: NumberPickerAdapter(
        data: [pickerColumn]
      ),
      hideHeader: false,
      height: MediaQuery.of(context).size.height * 0.30,
      itemExtent: 30.0,
      magnification: 1.5,
      squeeze: 0.80,
      diameterRatio: 4.0,
      textStyle: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.black, 
          letterSpacing: .5, 
          fontSize: 15.0, 
        )
      ),
      selectedTextStyle: TextStyle(
        color: Theme.of(context).primaryColor,
      ),
      cancelTextStyle: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.red, 
          letterSpacing: .5, 
          fontSize: 15.0,
          fontWeight: FontWeight.w600 
        )
      ),
      confirmTextStyle: GoogleFonts.muli(
        textStyle: TextStyle(
          color: Colors.black, 
          letterSpacing: .5, 
          fontSize: 15.0,
          fontWeight: FontWeight.w600 
        )
      ),
      onConfirm: onConfirm,
    );
  }

  Widget saveAction() {
    return Container(
      padding: EdgeInsets.only(top: 17.0, right: 20.0),
      child: InkWell(
        onTap: () {
          unfocusFields();
          if (_saveSkillKey.currentState.saveAndValidate()) {
            print(skill);
            print(_saveSkillKey.currentState.value);
          } else {
            print('Validation failed.');
          }
        },
        child: Text(
          'Save',
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
    );
  }

  Widget closeAction(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(Icons.close, color: Colors.white)
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocusFields,
      child: Stack(
        children: <Widget>[
          Scaffold(
            appBar: AppBar(
              leading: closeAction(context),
              actions: <Widget>[
                saveAction()
              ],
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: true,
              title: Text(
                widget.editMode ? 'Edit skill' : 'Add skill',
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
            body: Container(
              padding: EdgeInsets.all(20.0),
                child: ListView(
                children: <Widget>[
                  ...buildSaveSkillView(context),
                  buildDeleteButton()
                ]
              )
            )
          ),
        ]
      )
    );
  }
}