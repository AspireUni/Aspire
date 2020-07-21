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

class SaveExperience extends StatefulWidget {
  final bool editMode;
  final String jobId;

  SaveExperience({Key key, @required this.editMode, this.jobId}) 
    : super(key: key);

  @override
  _SaveExperienceState createState() => _SaveExperienceState();
}

class _SaveExperienceState extends State<SaveExperience> {
  final GlobalKey<FormBuilderState> _saveExperienceKey 
    = GlobalKey<FormBuilderState>();
  final FocusNode jobTitleFocus = FocusNode();
  final FocusNode companyFocus = FocusNode();
  
  bool isStartDateFocused, isEndDateFocused, isEndDateEnabled;
  Store<AppState> store; 
  String generatedId;

  String stateText;

  @override
  void initState() {
    super.initState();
   
    isStartDateFocused = false;
    isEndDateFocused = false;
    isEndDateEnabled = widget.editMode;

    textFieldFocusListener(jobTitleFocus, 'jobTitle');
    textFieldFocusListener(companyFocus, 'company');

     if (!widget.editMode) {
      generatedId = randomAlphaNumeric(10);
    }
  }

  @override
  void dispose() {
    jobTitleFocus.dispose();
    companyFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    return GestureDetector(
      onTap: unfocusFields,
      child: Scaffold(
        appBar: AppBarWithSave(
          appBarTitle: widget.editMode ? editExperience : addExperience,
          formKey: _saveExperienceKey,
          onActionTap: unfocusFields,
        ),
        backgroundColor: Colors.white,
        body: StoreConnector<AppState, Job>(
          converter: (store) => jobSelector(
            store, widget.jobId ?? generatedId
          ),
          builder: (context, job) => Container(
          padding: EdgeInsets.all(20.0),
            child: ListView(
              children: <Widget>[
                ...buildSaveExperienceForm(job),
                widget.editMode
                ? DeleteButton(
                  labelText: deleteExperience,
                  onPressed: () => 'Experience deleted.'
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
        _saveExperienceKey.currentState.fields[attribute].currentState
          .validate();
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
    var month = DateFormat.MMMM().format(date).toString();
    var year = DateFormat.y().format(date).toString();
    return '$month $year';
  }

  void showStartDatePicker(Job job) {
    DatePicker(
      yearOnly: false,
      initialValue: job.startDate != null 
        ? convertStringToDateTime(job.startDate)
        : DateTime.now(),
      maxValue: DateTime.now(),
      onConfirm: (picker, value) => handleStartDateConfirm(picker, job),
    ).build(context).showModal(context);
  }

  void showEndDatePicker(Job job) {
    DatePicker(
      yearOnly: false,
      initialValue: job.endDate != null 
        ? convertStringToDateTime(job.endDate)
        : convertStringToDateTime(job.startDate),
      minValue: convertStringToDateTime(job.startDate),
      maxValue: DateTime.now(),
      onConfirm: (picker, value) => handleEndDateConfirm(picker, job),
    ).build(context).showModal(context);
  }

  void handleStartDateConfirm(Picker picker, Job job) {
    var newStartDateTime = DateFormat('yyyy-MM-dd hh:mm:ss')
      .parse(picker.adapter.text);
    var newStartDate = convertDateTimeToString(newStartDateTime);
    store.dispatch(
      UpdateJob(
        job.copyWith(
          startDate: newStartDate,
          endDate: null
        )
      )
    );
    setState(() { isEndDateEnabled = true; });
    _saveExperienceKey.currentState.fields['startDate'].currentState
      .didChange(newStartDate);
    _saveExperienceKey.currentState.fields['endDate'].currentState
      .didChange(null);
    _saveExperienceKey.currentState.fields['startDate'].currentState
      .validate();
  }

  void handleEndDateConfirm(Picker picker, Job job) {
    var newEndDateTime = DateFormat('yyyy-MM-dd hh:mm:ss')
      .parse(picker.adapter.text);
    var newEndDate = convertDateTimeToString(newEndDateTime);
    store.dispatch(
      UpdateJob(
        job.copyWith(
          endDate: newEndDate
        )
      )
    );
    _saveExperienceKey.currentState.fields['endDate'].currentState
      .didChange(newEndDate);
    _saveExperienceKey.currentState.fields['endDate'].currentState
      .validate();
  }

  void handleCurrentJobSwitch(dynamic value, Job job){
    unfocusDateRangeFields();
    print(value);
    print(job);
    if (value as bool) {
      print("present!");
      store.dispatch(
        UpdateJob(
          job.copyWith(
            endDate: endDatePresent,
          )
        )
      );
      setState(() { isEndDateEnabled = false; });
      _saveExperienceKey.currentState.fields['endDate'].currentState
        .didChange(endDatePresent);
    } else {
      print("no!");

      store.dispatch(
        UpdateJob(
          job.copyWith(
            endDate: null
          )
        )
      );
      setState(() { isEndDateEnabled = true; });
      _saveExperienceKey.currentState.fields['endDate'].currentState
        .didChange(null);
    }
    _saveExperienceKey.currentState.fields['endDate'].currentState
      .validate();
  }

  Widget buildJobTitleField(Job job) {
    return FormBuilderTextField(
      attribute: 'jobTitle',
      initialValue: job.title,
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => store.dispatch(
        UpdateJob(
          job.copyWith(
            title: value,
            endDate: job.endDate
          )
        )
      ),
      focusNode: jobTitleFocus,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  Widget buildCompanyField(Job job) {
    return FormBuilderTextField(
      attribute: 'company',
      initialValue: job.company,
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => store.dispatch(
        UpdateJob(
          job.copyWith(
            company: value,
            endDate: job.endDate
          )
        )
      ),
      focusNode: companyFocus,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  Widget buildDateRangeRow(Job job) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.only(right: 10.0),
            child: InputField(
              labelText: saveExperienceStartDate,
              formField: buildStartPickerField(job),
            )
          )
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10.0),
            child: InputField(
              enabled: isEndDateEnabled && job.endDate != endDatePresent,
              labelText: saveExperienceEndDate,
              formField: buildEndPickerField(job),
            )
          )
        )
      ]
    );
  }

  Widget buildStartPickerField(Job job) {
    return PickerField(
      attribute: 'startDate',
      initialValue: job.startDate,
      isFocused: isStartDateFocused,
      isEnabled: true,
      value: job.startDate ?? '',
      onTap: () {
        unfocusTextFields();
        setState(() {
          isStartDateFocused = true;
          isEndDateFocused = false;
        });
        showStartDatePicker(job);
      }
    );
  }

  Widget buildEndPickerField(Job job) {
    return PickerField(
      attribute: 'endDate',
      initialValue: job.endDate,
      isFocused: isEndDateFocused,
      isEnabled: isEndDateEnabled  && job.endDate != endDatePresent,
      value: job.endDate ?? '',
      onTap: () {
        unfocusTextFields();
        setState(() {
          isStartDateFocused = false;
          isEndDateFocused = true;
        });
        showEndDatePicker(job);
      }
    );
  }

  Widget buildCurrentJobSwitch(Job job) {
    return  FormBuilderSwitch(
      attribute: 'currentJobSwitch',
      initialValue: job.endDate == endDatePresent,
      readOnly: job.startDate == null,
      label: Text(
        currentJobSwitchText,
        style: labelTextStyle(isEnabled: job.startDate != null),
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
      onChanged: (value) => handleCurrentJobSwitch(value, job),
    );
  }

  List<Widget> buildSaveExperienceForm(Job job) {
    return <Widget>[
      FormBuilder(
        key: _saveExperienceKey,
        child: Column(
          children: <Widget>[
            InputField(
              labelText: saveExperienceJobTitle,
              formField: buildJobTitleField(job)
            ),
            InputField(
              labelText: saveExperienceCompany,
              formField: buildCompanyField(job)
            ),
            buildDateRangeRow(job),
            buildCurrentJobSwitch(job)
          ]
        )
      ),
    ];
  }
}