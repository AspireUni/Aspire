import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../input_field.dart';

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
    isEndDateEnabled = widget.editMode;

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


  void onStartDateConfirm(Picker picker) {
    String newStartDate = picker.getSelectedValues()[0].toString();
    setState(() { 
      experience['startDate'] = newStartDate;
      experience['endDate'] = null;
    });
    _saveExperienceKey.currentState.fields['startDate'].currentState.didChange(newStartDate);
    _saveExperienceKey.currentState.fields['endDate'].currentState.didChange(null);
    
    _saveExperienceKey.currentState.fields['startDate'].currentState.validate();
  }

  void onEndDateConfirm(Picker picker) {
    String newEndDate = picker.getSelectedValues()[0].toString();
    setState(() => { experience['endDate'] = newEndDate });
    _saveExperienceKey.currentState.fields['endDate'].currentState.didChange(newEndDate);
    _saveExperienceKey.currentState.fields['endDate'].currentState.validate();
  }

  DateTime convertStringToDateTime(String date) {
    if (date == 'Present') {
      return DateTime.now();
    }
    return DateFormat("MMMM yyyy").parse(date);
  }

  String convertDateTimeToString(DateTime date) {
    String month = DateFormat.MMMM().format(date).toString();
    String year = DateFormat.y().format(date).toString();
    return '$month $year';
  }

  showStartDatePicker(BuildContext context) {
    Picker(
      adapter: DateTimePickerAdapter(
        value: experience['startDate'] != null ? convertStringToDateTime(experience['startDate']) : DateTime.now(),
        customColumnType: [1, 0],
        isNumberMonth: false,
        maxValue: DateTime.now(),
        yearBegin: 1950,
        yearEnd: 2030
      ),
      textAlign: TextAlign.right,
      onConfirm: (picker, value) {
        DateTime newStartDateTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(picker.adapter.text);
        String newStartDate = convertDateTimeToString(newStartDateTime);
        setState(() { 
          experience['startDate'] = newStartDate;
          experience['endDate'] = null;
        });
        _saveExperienceKey.currentState.fields['startDate'].currentState.didChange(newStartDate);
        _saveExperienceKey.currentState.fields['endDate'].currentState.didChange(null);
        
        _saveExperienceKey.currentState.fields['startDate'].currentState.validate();
      },
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

    ).showModal(context);
  }

  showEndDatePicker(BuildContext context) {
    Picker(
      adapter: DateTimePickerAdapter(
        value: experience['endDate'] != null 
          ? convertStringToDateTime(experience['endDate'])
          : convertStringToDateTime(experience['startDate']
        ),
        customColumnType: [1, 0],
        isNumberMonth: false,
        minValue: convertStringToDateTime(experience['startDate']),
        maxValue: DateTime.now(),
        yearEnd: 2030
      ),
      textAlign: TextAlign.right,
      onConfirm: (picker, value) {
        DateTime newEndDateTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(picker.adapter.text);
        String newEndDate = convertDateTimeToString(newEndDateTime);
        setState(() { 
          experience['endDate'] = newEndDate;
        });
        _saveExperienceKey.currentState.fields['endDate'].currentState.didChange(newEndDate);
        _saveExperienceKey.currentState.fields['endDate'].currentState.validate();
      },
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

    ).showModal(context);
  }

  List<Widget> buildSaveEducationView(context) {
    return <Widget>[
      FormBuilder(
        key: _saveExperienceKey,
        child: Column(
          children: <Widget>[
            InputField(
              labelText: 'Job title',
              formField: buildSchoolNameField()
            ),
            InputField(
              labelText: 'Company',
              formField: buildDegreeField()
            ),
            buildDateRangeFields(),
            buildCurrentJobSwitch()
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
          onPressed: () => print('Education deleted'),
          color: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: Text(
            'Delete experience',
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

  Widget buildSchoolNameField() {
    return FormBuilderTextField(
      attribute: 'jobTitle',
      initialValue: experience['jobTitle'],
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
      onChanged: (value) => setState(() { experience['jobTitle'] = value as String; }),
      focusNode: jobTitleFocus,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  Widget buildDegreeField() {
    return FormBuilderTextField(
      attribute: 'company',
      initialValue: experience['company'],
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
      onChanged: (value) => setState(() { experience['company'] = value as String; }),
      focusNode: companyFocus,
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
              labelText: 'Start date',
              formField: buildStartDateField(),
            )
          )
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10.0),
            child: InputField(
              enabled: isEndDateEnabled,
              labelText: 'End date',
              formField: buildEndDateField(),
            )
          )
        )
      ]
    );
  }

    Widget buildStartDateField() {
    return buildDateField(
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

  Widget buildEndDateField() {
    return buildDateField(
      attribute: 'endDate',
      initialValue: experience['endDate'],
      isFocused: isEndDateFocused,
      isEnabled: isEndDateEnabled,
      value: experience['endDate'] ?? '',
      onTap: isEndDateEnabled
        ? () {
          unfocusTextFields();
          setState(() {
            isStartDateFocused = false;
            isEndDateFocused = true;
          });
          showEndDatePicker(context);
        }
        : null
    );
  }

  Widget buildDateField({
    String attribute,
    String initialValue,
    bool isFocused,
    bool isEnabled,
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
                      color: isEnabled ? Colors.black : Colors.black38, 
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

  buildCurrentJobSwitch() {
    return  FormBuilderSwitch(
      attribute: 'currentJobSwitch',
      initialValue: experience['endDate'] == 'Present',
      readOnly: experience['startDate'] == null,
      label: Text(
        'I currently work here.',
        style: GoogleFonts.muli(
          textStyle: TextStyle(
            color: experience['startDate'] != null ? Colors.black : Colors.black38, 
            letterSpacing: .5, 
            fontSize: 13.0, 
          )
        ),
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
      onChanged: (value) {
        unfocusDateRangeFields();
        if (value) {
          setState(() { 
            experience['endDate'] = 'Present';
            isEndDateEnabled = false;
          });
          _saveExperienceKey.currentState.fields['endDate'].currentState.didChange('Present');
        } else {
          setState(() { 
            experience['endDate'] = null;
            isEndDateEnabled = true;
          });
          _saveExperienceKey.currentState.fields['endDate'].currentState.didChange(null);
        }
        _saveExperienceKey.currentState.fields['endDate'].currentState.validate();
      },
    );
  }

  Widget saveAction() {
    return Container(
      padding: EdgeInsets.only(top: 17.0, right: 20.0),
      child: InkWell(
        onTap: () {
          unfocusFields();
          if (_saveExperienceKey.currentState.saveAndValidate()) {
            print(experience);
            print(_saveExperienceKey.currentState.value);
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
                widget.editMode ? 'Edit experience' : 'Add experience',
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
                  ...buildSaveEducationView(context),
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