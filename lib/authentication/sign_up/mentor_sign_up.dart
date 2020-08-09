import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:smart_select/smart_select.dart';

import '../../common/common.dart';
import '../../constants/constants.dart';
import '../../helpers/helpers.dart';
import '../../icons/aspire_icons.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../firebase_authentication.dart';
import '../login.dart';
import '../password/link_sent.dart';


class MentorSignUp extends StatefulWidget {
  MentorSignUp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MentorSignUp();
}

class _MentorSignUp extends State<MentorSignUp> {
  final GlobalKey<FormBuilderState> _mentorSignUpFormKey
    = GlobalKey<FormBuilderState>();
  final FocusNode fullNameFocus = FocusNode();
  final FocusNode emailAddressFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode companyFocus = FocusNode();
  final FocusNode jobTitleFocus = FocusNode();

  String fullName,
    emailAddress,
    password,
    industry,
    company,
    jobTitle,
    startDate;
  List<String> areasOfExpertise;
  bool isFullNameFocused,
    isEmailAddressFocused,
    isPasswordFocused,
    isIndustryFocused,
    isAreasOfExpertiseFocused,
    isCompanyFocused,
    isJobTitleFocused,
    isStartDateFocused;
  bool isFullNameInvalid,
    isEmailAddressInvalid,
    isPasswordInvalid,
    isIndustryInvalid,
    isAreasOfExpertiseInvalid,
    isCompanyInvalid,
    isJobTitleInvalid,
    isStartDateInvalid;
  bool isLoading;
  Store<AppState> store;

  @override
  void initState() {
    super.initState();

    isLoading = false;

    isFullNameInvalid = false;
    isEmailAddressInvalid = false;
    isPasswordInvalid = false;
    isIndustryInvalid = false;
    isAreasOfExpertiseInvalid = false;
    isCompanyInvalid = false;
    isJobTitleInvalid = false;
    isStartDateInvalid = false;

    isFullNameFocused = false;
    isEmailAddressFocused = false;
    isPasswordFocused = false;
    isIndustryFocused = false;
    isAreasOfExpertiseFocused = false;
    isCompanyFocused = false;
    isJobTitleFocused = false;
    isStartDateFocused = false;
  
    fieldFocusListeners();

    store = StoreProvider.of<AppState>(context, listen: false);
  }

  @override
  void dispose() {
    fullNameFocus.dispose();
    emailAddressFocus.dispose();
    passwordFocus.dispose();
    companyFocus.dispose();
    jobTitleFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unfocusFields,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: GlobalHeader(
          actionText: signInAction,
          onActionTap: () => Navigator.pushReplacement(
            context, MaterialPageRoute(
              builder: (context) => Login()
            )
          )
        ),
        body: Stack(
          children: <Widget>[
            buildSignUpView(),
            buildCircularProgress(),
          ],
        )
      )
    );
  }

  void fieldFocusListeners() {
    fullNameFocus.addListener(() {
      setState(() { isFullNameFocused = fullNameFocus.hasFocus; });
    });
    emailAddressFocus.addListener(() {
      setState(() { isEmailAddressFocused = emailAddressFocus.hasFocus; });
    });
    passwordFocus.addListener(() {
      setState(() { isPasswordFocused = passwordFocus.hasFocus; });
    });
    companyFocus.addListener(() {
      setState(() { isCompanyFocused = companyFocus.hasFocus; });
    });
    jobTitleFocus.addListener(() {
      setState(() { isJobTitleFocused = jobTitleFocus.hasFocus; });
    });
  }

  void unfocusFields() {
    unfocusTextFields();
    unfocusCustomFields();
  }

  void unfocusTextFields() {
    fullNameFocus.unfocus();
    emailAddressFocus.unfocus();
    passwordFocus.unfocus();
    companyFocus.unfocus();
    jobTitleFocus.unfocus();
  }

  void unfocusCustomFields() {
    setState(() {
      isIndustryFocused = false;
      isAreasOfExpertiseFocused = false;
      isStartDateFocused = false;
    });
  }

  void validateAndSubmit() async {
    unfocusFields();
    setState(() {
      isLoading = true;
    });
    if (_mentorSignUpFormKey.currentState.saveAndValidate()) {
      try {
        await signUp();
        setState(() {
          isLoading = false;
          isFullNameInvalid = false;
          isEmailAddressInvalid = false;
          isPasswordInvalid = false;
          isIndustryInvalid = false;
          isAreasOfExpertiseInvalid = false;
          isCompanyInvalid = false;
          isJobTitleInvalid = false;
          isStartDateInvalid = false;
        });
      } on Exception catch (e) {
        print('Error: $e');
        setState(() {
          isLoading = false;
          _mentorSignUpFormKey.currentState.reset();
        });
      }
    } else {
        setState(() {
          isLoading = false;
          isFullNameInvalid = true;
          isEmailAddressInvalid = true;
          isPasswordInvalid = true;
          isIndustryInvalid = true;
          isAreasOfExpertiseInvalid = true;
          isCompanyInvalid = true;
          isJobTitleInvalid = true;
          isStartDateInvalid = true;
        });
    }
  }

  Future<void> signUp() async {
    try {
      var userId = await Auth().signUp(emailAddress, password);
      await Auth().sendEmailVerification();   
      await addMentor(
        userId,
        emailAddress: emailAddress,
        fullName: fullName,
        industry: industry,
        areasOfExpertise: areasOfExpertise,
        company: company,
        jobTitle: jobTitle,
        startDate: startDate
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LinkSent(
            emailAddress: emailAddress
          )
        )
      );
    } on PlatformException catch (e) {
      // TODO: Handle errors
      if (e.code =='ERROR_EMAIL_ALREADY_IN_USE') {
        print("Email address is already taken.");
      }
    }
  }

  Widget buildCircularProgress() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator()
      );
    }
    return SizedBox();
  }

  Widget buildSignUpView() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: ScreenSize.height * 0.10,
          child: buildCenterAno()
        ),
        Positioned(
          top: ScreenSize.height * 0.26,
          child: buildForm()
        ),
        buildFooter()
      ]
    );
  }

  Widget buildForm() {
    return Container(
      width: ScreenSize.width * 0.70,
      child: FormBuilder(
        key: _mentorSignUpFormKey,
        child: SizedBox(
          height: ScreenSize.height * 0.47,
          child: Center(
            child: ListView(
              padding: EdgeInsets.all(0.0),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                buildFullNameField(),
                buildEmailAddressField(),
                buildPasswordField(),
                buildCompanyField(),
                buildJobTitleField(),
                buildStartDateField(),
                buildIndustryField(),
                buildAreasOfExpertiseSelector()
              ]
            )
          )
        )
      )
    );
  }

  Widget buildCenterAno() {
    return Container(
      width: ScreenSize.width,
      child: Column(
        children: <Widget>[
          SvgPicture.asset(
            'images/diverse_ano.svg',
            height: ScreenSize.height * 0.11,
          ),
          Container(
            height: 1.5,
            color: Colors.black
          )
        ]
      )
    );
  }

  Widget buildFullNameField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FormBuilderTextField(
        attribute: 'fullName',
        focusNode: fullNameFocus,
        style: fieldTextStyle(color: ThemeColors.primary),
        decoration: fieldDecoration(
          isFocused: isFullNameFocused,
          isInvalid: isFullNameInvalid,
          hintText: fullNameHint,
          icon: AspireIcons.profile
        ),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(100),
        ],
        keyboardType: TextInputType.text,
        onTap: unfocusCustomFields,
        onChanged: (value) => setState(() { fullName = value as String; })
      )
    );
  }

  Widget buildEmailAddressField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FormBuilderTextField(
        attribute: 'emailAddress',
        focusNode: emailAddressFocus,
        style: fieldTextStyle(color: ThemeColors.primary),
        decoration: fieldDecoration(
          isFocused: isEmailAddressFocused,
          isInvalid: isEmailAddressInvalid,
          hintText: emailHint,
          icon: emailIconData
        ),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
          FormBuilderValidators.maxLength(100),
        ],
        keyboardType: TextInputType.emailAddress,
        onTap: unfocusCustomFields,
        onChanged: (value) => setState(() { emailAddress = value as String; })
      )
    );
  }

  Widget buildPasswordField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FormBuilderTextField(
        attribute: 'password',
        focusNode: passwordFocus,
        obscureText: true,
        maxLines: 1,
        style: fieldTextStyle(color: ThemeColors.primary),
        decoration: fieldDecoration(
          isFocused: isPasswordFocused,
          isInvalid: isPasswordInvalid,
          hintText: passwordHint,
          icon: lockIconData
        ),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(100),
        ],
        keyboardType: TextInputType.text,
        onTap: unfocusCustomFields,
        onChanged: (value) => setState(() { password = value as String; })
      )
    );
  }

  Widget buildCompanyField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FormBuilderTextField(
        attribute: 'company',
        focusNode: companyFocus,
        style: fieldTextStyle(color: ThemeColors.primary),
        decoration: fieldDecoration(
          isFocused: isCompanyFocused,
          isInvalid: isCompanyInvalid,
          hintText: currentCompanyHint,
          icon: briefCaseIconData
        ),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(100),
        ],
        keyboardType: TextInputType.text,
        onTap: unfocusCustomFields,
        onChanged: (value) => setState(() { company = value as String; })
      )
    );
  }

  Widget buildJobTitleField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FormBuilderTextField(
        attribute: 'jobTitle',
        focusNode: jobTitleFocus,
        style: fieldTextStyle(color: ThemeColors.primary),
        decoration: fieldDecoration(
          isFocused: isJobTitleFocused,
          isInvalid: isJobTitleInvalid,
          hintText: jobTitleHint,
          icon: briefCaseIconData
        ),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(100),
        ],
        keyboardType: TextInputType.text,
        onTap: unfocusCustomFields,
        onChanged: (value) => setState(() { jobTitle = value as String; })
      )
    );
  }

  Widget buildStartDateField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: CustomField(
        attribute: 'startDate',
        initialValue: startDate,
        hintText: startDateHint,
        icon: briefCaseIconData,
        isFocused: isStartDateFocused,
        isInvalid: isStartDateInvalid,
        isEnabled: true,
        value: startDate ?? '',
        onTap: () {
          unfocusTextFields();
          setState(() {
            isStartDateFocused = true;
            isIndustryFocused = false;
            isAreasOfExpertiseFocused = false;
          });
          showStartDatePicker(); 
        }
      )
    );
  }

  void showStartDatePicker() {
    DatePicker(
      titleText: startDateHint,
      yearOnly: false,
      initialValue: startDate != null 
        ? convertMonthYearStringToDateTime(startDate)
        : DateTime.now(),
      maxValue: DateTime.now(),
      onConfirm: (picker, value) => handleStartDateConfirm(picker),
    ).build(context).showModal(context);
  }

  void handleStartDateConfirm(Picker picker) {
    var newStartDateTime = DateFormat('yyyy-MM-dd hh:mm:ss')
      .parse(picker.adapter.text);
    var newStartDate = convertDateTimeToMonthYearString(newStartDateTime);
    setState(() { startDate = newStartDate; });
    _mentorSignUpFormKey.currentState.fields['startDate'].currentState
      .didChange(newStartDate);
  }

  Widget buildIndustryField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: CustomField(
        attribute: 'industry',
        initialValue: industry,
        hintText: industryHint,
        icon: briefCaseIconData,
        isFocused: isIndustryFocused,
        isInvalid: isIndustryInvalid,
        isEnabled: true,
        value: industry ?? '',
        onTap: () {
          unfocusTextFields();
          setState(() {
            isIndustryFocused = true;
            isAreasOfExpertiseFocused = false;
            isStartDateFocused = false;
          });
          showIndustryPicker(); 
        }
      )
    );
  }

  void showIndustryPicker() {
    ListPicker(
      titleText: industryHint,
      data: industries.map((item) => item['name']).toList(),
      selecteds: [industry != null
        ? industries.indexWhere((item) => industry == item['name'])
        : 0
      ],
      onConfirm: (picker, index) => handleIndustryConfirm(picker)
    ).build(context).showModal(context);
  }

  void handleIndustryConfirm(Picker picker) {
    var newIndustry = industries[picker.selecteds[0]]['name'] as String;
    setState(() {
      industry = newIndustry;
      areasOfExpertise = null;
    });
    _mentorSignUpFormKey.currentState.fields['industry']?.currentState
      ?.didChange(newIndustry);
    _mentorSignUpFormKey.currentState.fields['areasOfExpertise']?.currentState
      ?.didChange(null);
  }

  Widget buildAreasOfExpertiseSelector() {
    var options = <String>[];
    if (industry != null) {
      var chosenIndustry = (industries.singleWhere(
        (item) => item['name'] == industry)
      );
      options = chosenIndustry['areas'] as List<String>;
    }
    return MultiSelectModal(
      hintText: areasOfExpertiseHint,
      values: areasOfExpertise,
      options: options,
      onConfirm: handleAreasOfExpertiseConfirm,
      field: (context, state, showChoices) {
        return buildAreasOfExpertiseField(
          showSelector: options.isNotEmpty ? showChoices : null
        );
      }
    );
  }

  Widget buildAreasOfExpertiseField({SmartSelectShowModal showSelector}) {
    return showSelector != null
      ? Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: CustomField(
          attribute: 'areasOfExpertise',
          initialValue: null,
          hintText: areasOfExpertiseHint,
          icon: lightBulbIconData,
          isFocused: isAreasOfExpertiseFocused,
          isInvalid: isAreasOfExpertiseInvalid,
          isEnabled: showSelector != null,
          value: getAreasOfExpertiseDisplayString(),
          onTap: () {
            unfocusTextFields();
            setState(() {
              isAreasOfExpertiseFocused = true;
              isIndustryFocused = false;
              isStartDateFocused = false;
            });
            showSelector(context);
          }
        )
      ) : SizedBox();
  }

  String getAreasOfExpertiseDisplayString() {
    if (areasOfExpertise != null) {
      var suffix = '';
      if (areasOfExpertise.length > 1) {
        suffix = 's';
      }
      return '${areasOfExpertise.length} area$suffix of expertise selected';
    }
    return null;
  }
  
  void handleAreasOfExpertiseConfirm(List<String> values) {
    List<String> newAreas;
    if (values.isNotEmpty) {
      newAreas = values;
    }
    setState(() { areasOfExpertise = newAreas; });
    _mentorSignUpFormKey.currentState.fields['areasOfExpertise'].currentState
      .didChange(getAreasOfExpertiseDisplayString());
  }

  Widget buildFooter() {
    return Positioned(
      bottom: ScreenSize.height * 0.05,
      child: Column(
        children: <Widget>[
          CircleIndicators(stepIndex: 1),
          buildNextButton()
        ]
      )
    );
  }
  
  Widget buildNextButton() {
    return PrimaryButton(
      isLight: true,
      text: nextButtonText,
      onPressed: validateAndSubmit,
    );
  }
}
