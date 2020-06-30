import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:intl/intl.dart';

import '../../../../constants/profile_constants.dart';
import '../../../common/app_bar.dart';
import '../../../common/date_picker.dart';
import '../../../common/delete_button.dart';
import '../../../common/input_field.dart';
import '../../../common/picker_field.dart';
import '../../../common/styles.dart';

class SaveEducation extends StatefulWidget {
  final bool editMode;
  final Map<String, Object> schoolInfo;
  SaveEducation({Key key, @required this.editMode, this.schoolInfo}) : super(key: key);

  @override
  _SaveEducationState createState() => _SaveEducationState();
}

class _SaveEducationState extends State<SaveEducation> {
  final GlobalKey<FormBuilderState> _saveEducationKey = GlobalKey<FormBuilderState>();
  final FocusNode schoolFocus = FocusNode();
  final FocusNode degreeFocus = FocusNode();
  
  bool isStartYearFocused, isEndYearFocused;
  Map<String, Object> education;

  @override
  void initState() {
    super.initState();
   
    isStartYearFocused = false;
    isEndYearFocused = false;

    // Temporary workaround until we use global state management
    education = {
      'school': widget.editMode ? widget.schoolInfo['school'] : null,
      'degree': widget.editMode ? widget.schoolInfo['program'] : null,
      'startYear': widget.editMode ? widget.schoolInfo['startYear'] : null,
      'endYear': widget.editMode ? widget.schoolInfo['endYear'] : null
    };

    textFieldFocusListener(schoolFocus, 'school');
    textFieldFocusListener(degreeFocus, 'degree');
  }

  @override
  void dispose() {
    schoolFocus.dispose();
    degreeFocus.dispose();
    super.dispose();
  }

  void unfocusFields() {
    unfocusTextFields();
    unfocusDateRangeFields();
  }

  void unfocusTextFields() {
    schoolFocus.unfocus();
    degreeFocus.unfocus();
  }

  void unfocusDateRangeFields() {
    setState(() {
      isStartYearFocused = false;
      isEndYearFocused = false;
    });
  }

  void textFieldFocusListener(FocusNode focus, String attribute) {
    focus.addListener(() {
      if (focus.hasFocus) {
        unfocusDateRangeFields();
      } else {
        _saveEducationKey.currentState.fields[attribute].currentState.validate();
      }
    });
  }

  DateTime convertStringToDateTime(String date) {
    return DateFormat.y().parse(date);
  }

  String convertDateTimeToString(DateTime date) {
    return DateFormat.y().format(date).toString();
  }

  void showStartYearPicker(BuildContext context) {
    DatePicker(
      yearOnly: true,
      initialValue: education['startYear'] != null
        ? convertStringToDateTime(education['startYear'])
        : DateTime.now(),
      maxValue: DateTime.now(),
      onConfirm: (picker, value) => onStartYearConfirm(picker),
    ).build(context).showModal(context);
  }

  void showEndYearPicker(BuildContext context) {
    DatePicker(
      yearOnly: true,
      initialValue: education['endYear'] != null 
        ? convertStringToDateTime(education['endYear']) 
        : convertStringToDateTime(education['startYear']),
      minValue: convertStringToDateTime(education['startYear']),
      onConfirm: (picker, value) => onEndYearConfirm(picker),
    ).build(context).showModal(context);
  }

  void onStartYearConfirm(Picker picker) {
    DateTime newStartDateTime = DateFormat('yyyy-MM-dd hh:mm:ss').parse(picker.adapter.text);
    String newStartYear = convertDateTimeToString(newStartDateTime);
    setState(() { 
      education['startYear'] = newStartYear;
      education['endYear'] = null;
    });
    _saveEducationKey.currentState.fields['startYear'].currentState.didChange(newStartYear);
    _saveEducationKey.currentState.fields['endYear'].currentState.didChange(null);
    _saveEducationKey.currentState.fields['startYear'].currentState.validate();
  }

  void onEndYearConfirm(Picker picker) {
     DateTime newEndDateTime = DateFormat('yyyy-MM-dd hh:mm:ss').parse(picker.adapter.text);
    String newEndYear = convertDateTimeToString(newEndDateTime);
    setState(() => { education['endYear'] = newEndYear });
    _saveEducationKey.currentState.fields['endYear'].currentState.didChange(newEndYear);
    _saveEducationKey.currentState.fields['endYear'].currentState.validate();
  }

  Widget buildSchoolNameField() {
    return FormBuilderTextField(
      attribute: 'school',
      initialValue: education['school'],
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => setState(() { education['school'] = value as String; }),
      focusNode: schoolFocus,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  Widget buildDegreeField() {
    return FormBuilderTextField(
      attribute: 'degree',
      initialValue: education['degree'],
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => setState(() { education['degree'] = value as String; }),
      focusNode: degreeFocus,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  Widget buildDateRangeRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 10.0),
            child: InputField(
              labelText: saveEducationStartYear,
              formField: buildStartYearField(),
            )
          )
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10.0),
            child: InputField(
              enabled: education['startYear'] != null,
              labelText: saveEducationEndYear,
              formField: buildEndYearField(),
            )
          )
        )
      ]
    );
  }

  Widget buildStartYearField() {
    return PickerField(
      attribute: 'startYear',
      initialValue: education['startYear'],
      isEnabled: true,
      isFocused: isStartYearFocused,
      value: education['startYear'] ?? '',
      onTap: () {
        unfocusTextFields();
        setState(() {
          isStartYearFocused = true;
          isEndYearFocused = false;
        });
        showStartYearPicker(context);
      }
    );
  }

  Widget buildEndYearField() {
    return PickerField(
      attribute: 'endYear',
      initialValue: education['endYear'],
      isEnabled: education['startYear'] != null,
      isFocused: isEndYearFocused,
      value: education['endYear'] ?? '',
      onTap: () {
        unfocusTextFields();
        setState(() {
          isStartYearFocused = false;
          isEndYearFocused = true;
        });
        showEndYearPicker(context);
      }
    );
  }

  List<Widget> buildSaveEducationForm(context) {
    return <Widget>[
      FormBuilder(
        key: _saveEducationKey,
        child: Column(
          children: <Widget>[
            InputField(
              labelText: saveEducationSchool,
              formField: buildSchoolNameField()
            ),
            InputField(
              labelText: saveEducationDegree,
              formField: buildDegreeField()
            ),
            buildDateRangeRow()
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
              appBarTitle: widget.editMode ? editEducation : addEducation,
              data: education,
              formKey: _saveEducationKey
            ),
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.all(20.0),
                child: ListView(
                children: <Widget>[
                  ...buildSaveEducationForm(context),
                  widget.editMode
                  ? DeleteButton(
                    labelText: deleteEducation,
                    onPressed: () => 'Education deleted.'
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