import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:redux/redux.dart';

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
  final GlobalKey<FormBuilderState> _signUpFormKey
    = GlobalKey<FormBuilderState>();
  final FocusNode fullNameFocus = FocusNode();
  final FocusNode emailAddressFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  String fullName, emailAddress, password;
  bool isFullNameFocused, isEmailAddressFocused, isPasswordFocused;
  bool isFullNameInvalid, isEmailAddressInvalid, isPasswordInvalid;
  bool isLoading;
  Store<AppState> store;

  @override
  void initState() {
    super.initState();

    isLoading = false;

    isFullNameInvalid = false;
    isEmailAddressInvalid = false;
    isPasswordInvalid = false;

    isFullNameFocused = false;
    isEmailAddressFocused = false;
    isPasswordFocused = false;
  
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
    CommonContext().init(context);

    return Scaffold(
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

  void validateAndSubmit() async {
    setState(() {
      isLoading = true;
    });
    if (_signUpFormKey.currentState.saveAndValidate()) {
      try {
        await signUp();
        setState(() {
          isLoading = false;
          isFullNameInvalid = false;
          isEmailAddressInvalid = false;
          isPasswordInvalid = false;
        });
      } on Exception catch (e) {
        print('Error: $e');
        setState(() {
          isLoading = false;
          _signUpFormKey.currentState.reset();
        });
      }
    } else {
        setState(() {
          isLoading = false;
          isFullNameInvalid = true;
          isEmailAddressInvalid = true;
          isPasswordInvalid = true;
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
        fullName: fullName
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
          top: ScreenSize.screenHeight * 0.15,
          child: buildCenterAno()
        ),
        Positioned(
          top: ScreenSize.screenHeight * 0.35,
          child: buildForm()
        ),
        buildFooter()
      ]
    );
  }

  Widget buildForm() {
    return Container(
      width: ScreenSize.screenWidth * 0.60,
      child: FormBuilder(
        key: _signUpFormKey,
        child: Column(
          children: <Widget>[
            buildFullNameField(),
            buildEmailAddressField(),
            buildPasswordField(),
          ]
        )
      )
    );
  }

  Widget buildCenterAno() {
    return Container(
      width: ScreenSize.screenWidth,
      child: Column(
        children: <Widget>[
          SvgPicture.asset(
            'images/diverse_ano.svg',
            height: ScreenSize.screenHeight * 0.11,
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
          context,
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
        onSaved: (value) => fullName = (value as String),
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
          context,
          isFocused: isEmailAddressFocused,
          isInvalid: isEmailAddressInvalid,
          hintText: emailHint,
          icon: Icons.mail_outline
        ),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.email(),
          FormBuilderValidators.maxLength(100),
        ],
        keyboardType: TextInputType.emailAddress,
        onSaved: (value) => emailAddress = (value as String).trim(),
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
          context,
          isFocused: isPasswordFocused,
          isInvalid: isPasswordInvalid,
          hintText: passwordHint,
          icon: AspireIcons.lock
        ),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(100),
        ],
        keyboardType: TextInputType.text,
        onSaved: (value) => password = (value as String).trim(),
      )
    );
  }


  Widget buildFooter() {
    return Positioned(
      bottom: ScreenSize.screenHeight * 0.05,
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
