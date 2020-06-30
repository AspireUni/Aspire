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

class SaveExperience extends StatefulWidget {
  final bool editMode;
  final Map<String, Object> jobInfo;
  SaveExperience({Key key, @required this.editMode, this.jobInfo}) : super(key: key);

  @override
  _SaveExperienceState createState() => _SaveExperienceState();
}

class _SaveExperienceState extends State<SaveExperience> {
  final GlobalKey<FormBuilderState> _saveExperienceKey = GlobalKey<FormBuilderState>();
  final FocusNode jobTitleFocus = FocusNode();
  final FocusNode companyFocus = FocusNode();
  
  bool isStartDateFocused, isEndDateFocused, isEndDateEnabled;
  Map<String, Object> experience;

  String stateText;

  @override
  void initState() {
    super.initState();
   
    isStartDateFocused = false;
    isEndDateFocused = false;
    isEndDateEnabled = widget.editMode && widget.jobInfo['endDate'] != endDatePresent;

    // Temporary workaround until we use global state management
    experience = {
      'jobTitle': widget.editMode ? widget.jobInfo['jobTitle'] : null,
      'company': widget.editMode ? widget.jobInfo['company'] : null,
      'startDate': widget.editMode ? widget.jobInfo['startDate'] : null,
      'endDate': widget.editMode ? widget.jobInfo['endDate'] : null
    };

    textFieldFocusListener(jobTitleFocus, 'jobTitle');
    textFieldFocusListener(companyFocus, 'company');
  }

  @override
  void dispose() {
    jobTitleFocus.dispose();
    companyFocus.dispose();
    super.dispose();
  }

  void unfocusFields() {
    unfocusTextFields();
    unfocusDateRangeFields();
  }

  void unfocusTextFields() {
    jobTitleFocus.unfocus();
    companyFocus.unfocus();
  }

  void unfocusDateRangeFields() {
    setState(() {
      isStartDateFocused = false;
      isEndDateFocused = false;
    });
  }

  void textFieldFocusListener(FocusNode focus, String attribute) {
    focus.addListener(() {
      if (focus.hasFocus) {
        unfocusDateRangeFields();
      } else {
        _saveExperienceKey.currentState.fields[attribute].currentState.validate();
      }
    });
  }

  DateTime convertStringToDateTime(String date) {
    if (date == endDatePresent) {
      return DateTime.now();
    }
    return DateFormat('MMMM yyyy').parse(date);
  }

  String convertDateTimeToString(DateTime date) {
    String month = DateFormat.MMMM().format(date).toString();
    String year = DateFormat.y().format(date).toString();
    return '$month $year';
  }

  void showStartDatePicker(BuildContext context) {
    DatePicker(
      yearOnly: false,
      initialValue: experience['startDate'] != null 
        ? convertStringToDateTime(experience['startDate'])
        : DateTime.now(),
      maxValue: DateTime.now(),
      onConfirm: (picker, value) => onStartDateConfirm(picker),
    ).build(context).showModal(context);
  }

  void showEndDatePicker(BuildContext context) {
    DatePicker(
      yearOnly: false,
      initialValue: experience['endDate'] != null 
        ? convertStringToDateTime(experience['endDate'])
        : convertStringToDateTime(experience['startDate']),
      minValue: convertStringToDateTime(experience['startDate']),
      maxValue: DateTime.now(),
      onConfirm: (picker, value) => onEndDateConfirm(picker),
    ).build(context).showModal(context);
  }

  void onStartDateConfirm(Picker picker) {
    DateTime newStartDateTime = DateFormat('yyyy-MM-dd hh:mm:ss').parse(picker.adapter.text);
    String newStartDate = convertDateTimeToString(newStartDateTime);
    setState(() { 
      experience['startDate'] = newStartDate;
      experience['endDate'] = null;
      isEndDateEnabled = true;
    });
    _saveExperienceKey.currentState.fields['startDate'].currentState.didChange(newStartDate);
    _saveExperienceKey.currentState.fields['endDate'].currentState.didChange(null);
    _saveExperienceKey.currentState.fields['startDate'].currentState.validate();
  }

  void onEndDateConfirm(Picker picker) {
    DateTime newEndDateTime = DateFormat('yyyy-MM-dd hh:mm:ss').parse(picker.adapter.text);
    String newEndDate = convertDateTimeToString(newEndDateTime);
    setState(() { experience['endDate'] = newEndDate; });
    _saveExperienceKey.currentState.fields['endDate'].currentState.didChange(newEndDate);
    _saveExperienceKey.currentState.fields['endDate'].currentState.validate();
  }

  void onCurrentJobSwitch(dynamic value){
    unfocusDateRangeFields();
    if (value as bool) {
      setState(() { 
        experience['endDate'] = endDatePresent;
        isEndDateEnabled = false;
      });
      _saveExperienceKey.currentState.fields['endDate'].currentState.didChange(endDatePresent);
    } else {
      setState(() { 
        experience['endDate'] = null;
        isEndDateEnabled = true;
      });
      _saveExperienceKey.currentState.fields['endDate'].currentState.didChange(null);
    }
    _saveExperienceKey.currentState.fields['endDate'].currentState.validate();
  }

  Widget buildJobTitleField() {
    return FormBuilderTextField(
      attribute: 'jobTitle',
      initialValue: experience['jobTitle'],
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => setState(() { experience['jobTitle'] = value as String; }),
      focusNode: jobTitleFocus,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  Widget buildCompanyField() {
    return FormBuilderTextField(
      attribute: 'company',
      initialValue: experience['company'],
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => setState(() { experience['company'] = value as String; }),
      focusNode: companyFocus,
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
              labelText: saveExperienceStartDate,
              formField: buildStartPickerField(),
            )
          )
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10.0),
            child: InputField(
              enabled: isEndDateEnabled,
              labelText: saveExperienceEndDate,
              formField: buildEndPickerField(),
            )
          )
        )
      ]
    );
  }

  Widget buildStartPickerField() {
    return PickerField(
      attribute: 'startDate',
      initialValue: experience['startDate'],
      isFocused: isStartDateFocused,
      isEnabled: true,
      value: experience['startDate'] ?? '',
      onTap: () {
        unfocusTextFields();
        setState(() {
          isStartDateFocused = true;
          isEndDateFocused = false;
        });
        showStartDatePicker(context);
      }
    );
  }

  Widget buildEndPickerField() {
    return PickerField(
      attribute: 'endDate',
      initialValue: experience['endDate'],
      isFocused: isEndDateFocused,
      isEnabled: isEndDateEnabled,
      value: experience['endDate'] ?? '',
      onTap: () {
        unfocusTextFields();
        setState(() {
          isStartDateFocused = false;
          isEndDateFocused = true;
        });
        showEndDatePicker(context);
      }
    );
  }

  Widget buildCurrentJobSwitch() {
    return  FormBuilderSwitch(
      attribute: 'currentJobSwitch',
      initialValue: experience['endDate'] == endDatePresent,
      readOnly: experience['startDate'] == null,
      label: Text(
        currentJobSwitchText,
        style: labelTextStyle(isEnabled: experience['startDate'] != null),
      ),
      contentPadding: EdgeInsets.all(0.0),
      activeColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(0.0),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none
      ),
      onChanged: onCurrentJobSwitch,
    );
  }

  List<Widget> buildSaveExperienceForm(context) {
    return <Widget>[
      FormBuilder(
        key: _saveExperienceKey,
        child: Column(
          children: <Widget>[
            InputField(
              labelText: saveExperienceJobTitle,
              formField: buildJobTitleField()
            ),
            InputField(
              labelText: saveExperienceCompany,
              formField: buildCompanyField()
            ),
            buildDateRangeRow(),
            buildCurrentJobSwitch()
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
              appBarTitle: widget.editMode ? editExperience : addExperience,
              data: experience,
              formKey: _saveExperienceKey
            ),
            backgroundColor: Colors.white,
            body: Container(
              padding: EdgeInsets.all(20.0),
                child: ListView(
                children: <Widget>[
                  ...buildSaveExperienceForm(context),
                  widget.editMode
                  ? DeleteButton(
                    labelText: deleteExperience,
                    onPressed: () => 'Experience deleted.'
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