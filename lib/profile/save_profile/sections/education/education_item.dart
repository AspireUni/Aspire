import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:random_string/random_string.dart';
import 'package:redux/redux.dart';

import '../../../../actions/actions.dart';
import '../../../../common/common.dart';
import '../../../../constants/profile_constants.dart';
import '../../../../helpers/helpers.dart';
import '../../../../icons/aspire_icons.dart';
import '../../../../models/models.dart';
import '../../../../selectors/selectors.dart';
import '../../../common/date_picker.dart';
import '../../../common/input_field.dart';
import '../../../common/picker_field.dart';

class SaveEducationItem extends StatefulWidget {
  final bool editMode;
  final String schoolId;

  SaveEducationItem({Key key, @required this.editMode, this.schoolId}) 
    : super(key: key);

  @override
  _SaveEducationItemState createState() => _SaveEducationItemState();
}

class _SaveEducationItemState extends State<SaveEducationItem> {
  final GlobalKey<FormBuilderState> _saveEducationItemKey 
    = GlobalKey<FormBuilderState>();
  final FocusNode schoolFocus = FocusNode();
  final FocusNode degreeFocus = FocusNode();
  
  bool isStartYearFocused, isEndYearFocused, isActive;

  bool isSchoolNameFocused, isDegreeFocused;
  bool isSchoolNameInvalid, isDegreeInvalid;

  Store<AppState> store; 
  String generatedId;
  double screenHeight, screenWidth;

  @override
  void initState() {
    super.initState();
   
    isStartYearFocused = false;
    isEndYearFocused = false;
    isActive = true;

    textFieldFocusListener(schoolFocus, 'school');
    textFieldFocusListener(degreeFocus, 'degree');

    if (!widget.editMode) {
      generatedId = randomAlphaNumeric(15);
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

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    
    isSchoolNameInvalid = false;
    isDegreeInvalid = false;
    isSchoolNameFocused = false;
    isDegreeFocused = false;

    return GestureDetector(
      onTap: unfocusFields,
      child: Scaffold(
        appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
            iconSize: screenHeight * 0.02,
            onPressed: () {
              handleClose();
            },
            icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).accentColor
              )
            ),
            backgroundColor: Colors.white,
          ),
        backgroundColor: Colors.white,
        body: StoreConnector<AppState, School>(
          converter: (store) => saveEducationStateSelector(
            store,
            id: widget.schoolId ?? generatedId,
            editMode: widget.editMode,
            isPageActive: isActive
          ),
          builder: (context, school) => Container(
              child: ListView(
              children: <Widget>[
                buildCenterAno(),
                ...buildSaveEducationItemForm(school),
                buildAddButton()
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
        _saveEducationItemKey.currentState.fields[attribute].currentState
          .validate();
      }
    });
  }

  void showStartYearPicker(School school) {
    ProfileDatePicker(
      yearOnly: true,
      initialValue: school.startYear != null
        ? convertYearStringToDateTime(school.startYear)
        : DateTime.now(),
      maxValue: DateTime.now(),
      onConfirm: (picker, value) => handleStartYearConfirm(picker, school),
    ).build(context).showModal(context);
  }

  void showEndYearPicker(School school) {
    ProfileDatePicker(
      yearOnly: true,
      initialValue: school.endYear != null 
        ? convertYearStringToDateTime(school.endYear) 
        : convertYearStringToDateTime(school.startYear),
      minValue: convertYearStringToDateTime(school.startYear),
      onConfirm: (picker, value) => handleEndYearConfirm(picker, school),
    ).build(context).showModal(context);
  }

  void handleSaveEducation() {
    if (_saveEducationItemKey.currentState.saveAndValidate()) {
        store.dispatch(SaveSchool(payload: widget.editMode));
        setState(() { isActive = false; });
        unfocusFields();
        Navigator.pop(context);
    } else {
       print("Validation failed.");
    }
  }

  void handleDeleteEducation() {
    store.dispatch(DeleteSchool());
    setState(() { isActive = false; });
    unfocusFields();
    Navigator.pop(context);
  }

  void handleClose() {
    store.dispatch(UpdateSaveEducationState(School.initial()));
    setState(() { isActive = false; });
    Navigator.pop(context);
  }

  void handleStartYearConfirm(Picker picker, School school) {
    var newStartDateTime = DateFormat('yyyy-MM-dd hh:mm:ss')
      .parse(picker.adapter.text);
    var newStartYear = convertDateTimeToYearString(newStartDateTime);
    store.dispatch(
      UpdateSaveEducationState(
        school.copyWith(
          startYear: newStartYear,
          endYear: null
        )
      )
    );
    _saveEducationItemKey.currentState.fields['startYear'].currentState
      .didChange(newStartYear);
    _saveEducationItemKey.currentState.fields['endYear'].currentState
      .didChange(null);
    _saveEducationItemKey
      .currentState
      .fields['startYear']
      .currentState
      .validate();
  }

  void handleEndYearConfirm(Picker picker, School school) {
    var newEndDateTime = DateFormat('yyyy-MM-dd hh:mm:ss') 
      .parse(picker.adapter.text);
    var newEndYear = convertDateTimeToYearString(newEndDateTime);
    store.dispatch(
      UpdateSaveEducationState(
        school.copyWith(
          endYear: newEndYear
        )
      )
    );
    _saveEducationItemKey.currentState.fields['endYear'].currentState.
      didChange(newEndYear);
    _saveEducationItemKey
      .currentState
      .fields['endYear']
      .currentState
      .validate();
  }


  Widget buildDateRangeRow(School school) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 60.0, right: 10.0),
            child: InputField(
              labelText: saveEducationStartYear,
              formField: buildStartYearField(school),
            )
          )
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10.0, right: 60.0),
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

  List<Widget> buildSaveEducationItemForm(School school) {
    return <Widget>[
      FormBuilder(
        key: _saveEducationItemKey,
        child: Column(
          children: <Widget>[
            buildSchoolNameField(school),
            buildDegreeField(school),
            buildDateRangeRow(school)
          ]
        )
      ),
    ];
  }

  Widget buildCenterAno() {
    return Container(
      padding: EdgeInsets.only(bottom: 60.0),
      width: screenWidth,
      child: Column(
        children: <Widget>[
          Image.asset(
            'images/two_anos_talking.png',
            height: screenHeight * 0.20,
          ),
          Container(
            height: 1.5,
            color: Colors.black
          )
        ]
      )
    );
  }


  Widget buildSchoolNameField(School school) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0, left: 60.0, right: 60.0),
      child: FormBuilderTextField(
        attribute: 'school',
        initialValue: school.name,
        focusNode: schoolFocus,
        maxLines: 1,
        style: fieldTextStyle(color: Theme.of(context).primaryColor),
        onChanged: (value) => store.dispatch(
        UpdateSaveEducationState(
          school.copyWith(
            name: value,
            endYear: school.endYear
            )
          )
        ),
        decoration: fieldDecoration(
          isFocused: isSchoolNameFocused,
          isInvalid: isSchoolNameInvalid,
          hintText: buildSchoolNameHint,
          icon: AspireIcons.lock
        ),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(100),
        ],
        keyboardType: TextInputType.text,
      )
    );
  }


  Widget buildDegreeField(School school) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0, left: 60.0, right: 60.0),
      child: FormBuilderTextField(
        attribute: 'degree',
        initialValue: school.program,
        focusNode: degreeFocus,
        maxLines: 1,
        style: fieldTextStyle(color: Theme.of(context).primaryColor),
        onChanged: (value) => store.dispatch(
        UpdateSaveEducationState(
          school.copyWith(
            program: value,
            endYear: school.endYear
            )
          )
        ),
        decoration: fieldDecoration(
          isFocused: isDegreeFocused,
          isInvalid: isDegreeInvalid,
          hintText: buildDegreeFieldHint,
          icon: AspireIcons.lock
        ),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(100),
        ],
        keyboardType: TextInputType.text,
      )
    );
  }

  Widget buildAddButton() {
    return Container(
      padding: EdgeInsets.only(top:100.0, bottom: 20.0, 
      left: 60.0, right: 60.0),
      child: PrimaryButton(
        isLight: true,
        text: widget.editMode ? 'Edit' : 'Add',
        onPressed: () {
          handleSaveEducation();  
        },
      )
    );
  }

}