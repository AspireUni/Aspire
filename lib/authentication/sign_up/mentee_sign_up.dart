import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';
import 'package:smart_select/smart_select.dart';

import '../../common/common.dart';
import '../../constants/constants.dart';
import '../../icons/aspire_icons.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../firebase_authentication.dart';
import '../login.dart';
import '../password/link_sent.dart';


class MenteeSignUp extends StatefulWidget {
  MenteeSignUp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenteeSignUp();
}

class _MenteeSignUp extends State<MenteeSignUp> {
  final GlobalKey<FormBuilderState> _menteeSignUpFormKey
    = GlobalKey<FormBuilderState>();
  final FocusNode fullNameFocus = FocusNode();
  final FocusNode emailAddressFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  String fullName, emailAddress, password, industry;
  List<String> areasOfInterest;
  bool isFullNameFocused,
    isEmailAddressFocused,
    isPasswordFocused,
    isIndustryFocused,
    isAreasOfInterestFocused;
  bool isFullNameInvalid,
    isEmailAddressInvalid,
    isPasswordInvalid,
    isIndustryInvalid,
    isAreasOfInterestInvalid;
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
    isAreasOfInterestInvalid = false;

    isFullNameFocused = false;
    isEmailAddressFocused = false;
    isPasswordFocused = false;
    isIndustryFocused = false;
    isAreasOfInterestFocused = false;
  
    fieldFocusListeners();

    store = StoreProvider.of<AppState>(context, listen: false);
  }

  @override
  void dispose() {
    fullNameFocus.dispose();
    emailAddressFocus.dispose();
    passwordFocus.dispose();
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
  }

  void unfocusFields() {
    fullNameFocus.unfocus();
    emailAddressFocus.unfocus();
    passwordFocus.unfocus();
    unfocusCustomFields();
  }

  void unfocusCustomFields() {
    unfocusIndustryField();
    unfocusAreasOfInterestField();
  }

  void unfocusIndustryField() {
    setState(() {
      isIndustryFocused = false;
    });
  }

  void unfocusAreasOfInterestField() {
    setState(() {
      isAreasOfInterestFocused = false;
    });
  }

  void validateAndSubmit() async {
    unfocusFields();
    setState(() {
      isLoading = true;
    });
    if (_menteeSignUpFormKey.currentState.saveAndValidate()) {
      try {
        await signUp();
        setState(() {
          isLoading = false;
          isFullNameInvalid = false;
          isEmailAddressInvalid = false;
          isPasswordInvalid = false;
          isIndustryInvalid = false;
          isAreasOfInterestInvalid = false;
        });
      } on Exception catch (e) {
        print('Error: $e');
        setState(() {
          isLoading = false;
          _menteeSignUpFormKey.currentState.reset();
        });
      }
    } else {
        setState(() {
          isLoading = false;
          isFullNameInvalid = true;
          isEmailAddressInvalid = true;
          isPasswordInvalid = true;
          isIndustryInvalid = true;
          isAreasOfInterestInvalid = true;
        });
    }
  }

  Future<void> signUp() async {
    try {
      var userId = await Auth().signUp(emailAddress, password);
      await Auth().sendEmailVerification();   
      await addMentee(
        userId,
        emailAddress: emailAddress,
        fullName: fullName,
        industry: industry,
        areasOfInterest: areasOfInterest
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
        key: _menteeSignUpFormKey,
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
                buildIndustryField(),
                buildAreasOfInterestSelector()
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
          setState(() {
            isIndustryFocused = true;
            isAreasOfInterestFocused = false;
          });
          showIndustryPicker(); 
        }
      )
    );
  }

  void showIndustryPicker() {
    ListPicker(
      titleText: industryHint,
      data: industries.map((item) => item.name).toList(),
      selecteds: [industry != null
        ? industries.indexWhere((item) => industry == item.name)
        : 0
      ],
      onConfirm: (picker, index) => handleIndustryConfirm(picker)
    ).build(context).showModal(context);
  }

  void handleIndustryConfirm(Picker picker) {
    var newIndustry = industries[picker.selecteds[0]].name;
    setState(() {
      industry = newIndustry;
      areasOfInterest = null;
    });
    _menteeSignUpFormKey.currentState.fields['industry']?.currentState
      ?.didChange(newIndustry);
    _menteeSignUpFormKey.currentState.fields['areasOfInterest']?.currentState
      ?.didChange(null);
  }

  Widget buildAreasOfInterestSelector() {
    var options = <String>[];
    if (industry != null) {
      var chosenIndustry = (industries.singleWhere(
        (item) => item.name == industry)
      );
      options = chosenIndustry.areas;
    }
    return MultiSelectModal(
      hintText: areasOfInterestHint,
      values: areasOfInterest,
      options: options,
      onConfirm: handleAreasOfInterestConfirm,
      field: (context, state, showChoices) {
        return buildAreasOfInterestField(
          showSelector: options.isNotEmpty ? showChoices : null
        );
      }
    );
  }

  Widget buildAreasOfInterestField({SmartSelectShowModal showSelector}) {
    return CustomField(
      attribute: 'areasOfInterest',
      initialValue: null,
      hintText: areasOfInterestHint,
      icon: lightBulbIconData,
      isFocused: isAreasOfInterestFocused,
      isInvalid: isAreasOfInterestInvalid,
      isEnabled: showSelector != null,
      value: getAreasOfInterestDisplayString(),
      onTap: () {
        setState(() {
          isAreasOfInterestFocused = true;
          isIndustryFocused = false;
        });
        showSelector(context);
      }
    );
  }

  String getAreasOfInterestDisplayString() {
    if (areasOfInterest != null) {
      var suffix = '';
      if (areasOfInterest.length > 1) {
        suffix = 's';
      }
      return '${areasOfInterest.length} area$suffix of interest selected';
    }
    return null;
  }
  
  void handleAreasOfInterestConfirm(List<String> values) {
    List<String> newAreas;
    if (values.isNotEmpty) {
      newAreas = values;
    }
    setState(() { areasOfInterest = newAreas; });
    _menteeSignUpFormKey.currentState.fields['areasOfInterest'].currentState
      .didChange(getAreasOfInterestDisplayString());
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
