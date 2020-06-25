import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../input_field.dart';

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


  void onStartYearConfirm(Picker picker) {
    String newStartDate = picker.getSelectedValues()[0].toString();
    setState(() { 
      education['startYear'] = newStartDate;
      education['endYear'] = null;
    });
    _saveEducationKey.currentState.fields['startYear'].currentState.didChange(newStartDate);
    _saveEducationKey.currentState.fields['endYear'].currentState.didChange(null);
    
    _saveEducationKey.currentState.fields['startYear'].currentState.validate();
  }

  void onEndYearConfirm(Picker picker) {
    String newEndDate = picker.getSelectedValues()[0].toString();
    setState(() => { education['endYear'] = newEndDate });
    _saveEducationKey.currentState.fields['endYear'].currentState.didChange(newEndDate);
    _saveEducationKey.currentState.fields['endYear'].currentState.validate();
  }

  void showStartYearPicker(BuildContext context) {
    buildYearPicker(
      context,
      NumberPickerColumn(
        begin: 1950,
        end: 2020,
        initValue: education['startYear'] != null
          ? int.parse(education['startYear'])
          : 2010
      ),
      (picker, value) => onStartYearConfirm(picker)
    ).showModal(context);
  }
  
  void showEndYearPicker(BuildContext context) {
   buildYearPicker(
      context,
      NumberPickerColumn(
            begin: int.parse(education['startYear']),
            end: 2030,
            initValue: education['endYear'] != null 
              ? int.parse(education['endYear']) 
              : int.parse(education['startYear'])
          ),
      (picker, value) => onEndYearConfirm(picker)
    ).showModal(context);
  }

  List<Widget> buildSaveEducationView(context) {
    return <Widget>[
      FormBuilder(
        key: _saveEducationKey,
        child: Column(
          children: <Widget>[
            InputField(
              labelText: 'School',
              formField: buildSchoolNameField()
            ),
            InputField(
              labelText: 'Degree',
              formField: buildDegreeField()
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
          onPressed: () => print('Education deleted'),
          color: Colors.redAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))
          ),
          child: Text(
            'Delete education',
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
      attribute: 'school',
      initialValue: education['school'],
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
      onChanged: (value) => setState(() { education['degree'] = value as String; }),
      focusNode: degreeFocus,
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
              labelText: 'Start year',
              formField: buildStartYearField(),
            )
          )
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(left: 10.0),
            child: InputField(
              enabled: education['startYear'] != null,
              labelText: 'End year',
              formField: buildEndYearField(),
            )
          )
        )
      ]
    );
  }

    Widget buildStartYearField() {
    return buildYearField(
      attribute: 'startYear',
      initialValue: education['startYear'],
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
    return buildYearField(
      attribute: 'endYear',
      initialValue: education['endYear'],
      isFocused: isEndYearFocused,
      value: education['endYear'] ?? '',
      onTap: education['startYear'] != null
        ? () {
          unfocusTextFields();
          setState(() {
            isStartYearFocused = false;
            isEndYearFocused = true;
          });
          showEndYearPicker(context);
        }
        : null
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
          if (_saveEducationKey.currentState.saveAndValidate()) {
            print(education);
            print(_saveEducationKey.currentState.value);
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
                widget.editMode ? 'Edit education' : 'Add education',
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