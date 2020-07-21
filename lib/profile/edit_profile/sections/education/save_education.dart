import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:redux/redux.dart';

import '../../../../actions/actions.dart';
import '../../../../constants/profile_constants.dart';
import '../../../../models/models.dart';
import '../../../../selectors/selectors.dart';
import '../../../common/app_bar.dart';
import '../../../common/date_picker.dart';
import '../../../common/delete_button.dart';
import '../../../common/input_field.dart';
import '../../../common/picker_field.dart';
import '../../../common/styles.dart';

class SaveEducation extends StatefulWidget {
  final bool editMode;
  final String schoolId;

  SaveEducation({Key key, @required this.editMode, this.schoolId}) 
    : super(key: key);

  @override
  _SaveEducationState createState() => _SaveEducationState();
}

class _SaveEducationState extends State<SaveEducation> {
  final GlobalKey<FormBuilderState> _saveEducationKey 
    = GlobalKey<FormBuilderState>();
  final FocusNode schoolFocus = FocusNode();
  final FocusNode degreeFocus = FocusNode();
  
  bool isStartYearFocused, isEndYearFocused;
  Store<AppState> store; 
  String generatedId;

  @override
  void initState() {
    super.initState();
   
    isStartYearFocused = false;
    isEndYearFocused = false;

    textFieldFocusListener(schoolFocus, 'school');
    textFieldFocusListener(degreeFocus, 'degree');

    if (!widget.editMode) {
      generatedId = randomAlphaNumeric(10);
    }
  }

  @override
  void dispose() {
    schoolFocus.dispose();
    degreeFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    return GestureDetector(
      onTap: unfocusFields,
      child: Scaffold(
        appBar: AppBarWithSave(
          appBarTitle: widget.editMode ? editEducation : addEducation,
          formKey: _saveEducationKey,
          onActionTap: unfocusFields,
        ),
        backgroundColor: Colors.white,
        body: StoreConnector<AppState, School>(
          converter: (store) => schoolSelector(
            store, widget.schoolId ?? generatedId
          ),
          builder: (context, school) => Container(
            padding: EdgeInsets.all(20.0),
              child: ListView(
              children: <Widget>[
                ...buildSaveEducationForm(school),
                widget.editMode
                ? DeleteButton(
                  labelText: deleteEducation,
                  onPressed: () => 'Education deleted.'
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
        _saveEducationKey.currentState.fields[attribute].currentState
          .validate();
      }
    });
  }

  DateTime convertStringToDateTime(String date) {
    return DateFormat.y().parse(date);
  }

  String convertDateTimeToString(DateTime date) {
    return DateFormat.y().format(date).toString();
  }

  void showStartYearPicker(School school) {
    print(school);
    DatePicker(
      yearOnly: true,
      initialValue: school.startYear != null
        ? convertStringToDateTime(school.startYear)
        : DateTime.now(),
      maxValue: DateTime.now(),
      onConfirm: (picker, value) => handleStartYearConfirm(picker, school),
    ).build(context).showModal(context);
  }

  void showEndYearPicker(School school) {
    DatePicker(
      yearOnly: true,
      initialValue: school.endYear != null 
        ? convertStringToDateTime(school.endYear) 
        : convertStringToDateTime(school.startYear),
      minValue: convertStringToDateTime(school.startYear),
      onConfirm: (picker, value) => handleEndYearConfirm(picker, school),
    ).build(context).showModal(context);
  }

  void handleStartYearConfirm(Picker picker, School school) {
    var newStartDateTime = DateFormat('yyyy-MM-dd hh:mm:ss')
      .parse(picker.adapter.text);
    var newStartYear = convertDateTimeToString(newStartDateTime);
    store.dispatch(
      UpdateSchool(
        school.copyWith(
          startYear: newStartYear,
          endYear: null
        )
      )
    );
    _saveEducationKey.currentState.fields['startYear'].currentState
      .didChange(newStartYear);
    _saveEducationKey.currentState.fields['endYear'].currentState
      .didChange(null);
    _saveEducationKey.currentState.fields['startYear'].currentState.validate();
  }

  void handleEndYearConfirm(Picker picker, School school) {
    var newEndDateTime = DateFormat('yyyy-MM-dd hh:mm:ss') 
      .parse(picker.adapter.text);
    var newEndYear = convertDateTimeToString(newEndDateTime);
    store.dispatch(
      UpdateSchool(
        school.copyWith(
          endYear: newEndYear
        )
      )
    );
    _saveEducationKey.currentState.fields['endYear'].currentState.
      didChange(newEndYear);
    _saveEducationKey.currentState.fields['endYear'].currentState.validate();
  }

  Widget buildSchoolNameField(School school) {
    return FormBuilderTextField(
      attribute: 'school',
      initialValue: school.name,
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => store.dispatch(
        UpdateSchool(
          school.copyWith(
            name: value,
            endYear: school.endYear
          )
        )
      ),
      focusNode: schoolFocus,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  Widget buildDegreeField(School school) {
    return FormBuilderTextField(
      attribute: 'degree',
      initialValue: school.program,
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => store.dispatch(
        UpdateSchool(
          school.copyWith(
            program: value,
            endYear: school.endYear
          )
        )
      ),
      focusNode: degreeFocus,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  Widget buildDateRangeRow(School school) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 10.0),
            child: InputField(
              labelText: saveEducationStartYear,
              formField: buildStartYearField(school),
            )
          )
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10.0),
            child: InputField(
              enabled: school.startYear != null,
              labelText: saveEducationEndYear,
              formField: buildEndYearField(school),
            )
          )
        )
      ]
    );
  }

  Widget buildStartYearField(School school) {
    return PickerField(
      attribute: 'startYear',
      initialValue: school.startYear,
      isEnabled: true,
      isFocused: isStartYearFocused,
      value: school.startYear ?? '',
      onTap: () {
        unfocusTextFields();
        setState(() {
          isStartYearFocused = true;
          isEndYearFocused = false;
        });
        showStartYearPicker(school);
      }
    );
  }

  Widget buildEndYearField(School school) {
    return PickerField(
      attribute: 'endYear',
      initialValue: school.endYear,
      isEnabled: school.startYear != null,
      isFocused: isEndYearFocused,
      value: school.endYear ?? '',
      onTap: () {
        unfocusTextFields();
        setState(() {
          isStartYearFocused = false;
          isEndYearFocused = true;
        });
        showEndYearPicker(school);
      }
    );
  }

  List<Widget> buildSaveEducationForm(School school) {
    return <Widget>[
      FormBuilder(
        key: _saveEducationKey,
        child: Column(
          children: <Widget>[
            InputField(
              labelText: saveEducationSchool,
              formField: buildSchoolNameField(school)
            ),
            InputField(
              labelText: saveEducationDegree,
              formField: buildDegreeField(school)
            ),
            buildDateRangeRow(school)
          ]
        )
      ),
    ];
  }
}