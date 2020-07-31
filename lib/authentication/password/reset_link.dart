import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../common/common.dart';
import '../../constants/constants.dart';
import '../firebase_authentication.dart';
import '../login.dart';
import './link_sent.dart';


class ResetLink extends StatefulWidget {

  ResetLink({ Key key }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ResetLink();
}

class _ResetLink extends State<ResetLink> {
  final GlobalKey<FormBuilderState> _emailAddressFormKey
    = GlobalKey<FormBuilderState>();

  double screenHeight, screenWidth;
  bool isLoading, isEmailAddressInvalid;
  String emailAddress;

  @override
  void initState() {
    super.initState();
    
    isLoading = false;
    isEmailAddressInvalid = false;
  }


  @override
  Widget build(BuildContext context) {

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

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
      body: buildLinkSentView()
    );
  }

  Widget buildLinkSentView() {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned(
          top: screenHeight * 0.15,
          child: buildCenterAno()
        ),
        Positioned(
          top: screenHeight * 0.35,
          child: buildForm()
        ), 
        Positioned(
          top: screenHeight * 0.50,
          child: buildResetLinkButton()
        )
      ]
    );
  }

 Widget buildCenterAno() {
    return Container(
      width: screenWidth,
      child: Column(
        children: <Widget>[
          Image.asset(
            'images/sign_up/ano_hands_straight_up.png', 
            height: screenHeight * 0.10
          ),
          Container(
            height: 1.5,
            color: Colors.black
          )
        ]
      )
    );
  }

  Widget buildForm() {
    return Container(
      width: screenWidth * 0.60,
      child: FormBuilder(
        key: _emailAddressFormKey,
        child: buildEmailAddressField()
      )
    );
  }

  Widget buildEmailAddressField() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: FormBuilderTextField(
        attribute: 'emailAddress',
        autofocus: true, 
        decoration: fieldDecoration(
          context,
          isFocused: true,
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
        onSaved: (value) => emailAddress = (value as String).trim()
      )
    );
  }
  
  Widget buildResetLinkButton() {
    return PrimaryButton(
        isLight: true,
        text: getResetLinkText,
        onPressed: validateAndSubmit
    );
  }

void validateAndSubmit() async {
    setState(() {
      isLoading = true;
    });
    if (_emailAddressFormKey.currentState.saveAndValidate()) {
      try {
        await Auth().resetPassword(emailAddress);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LinkSent(
              emailAddress: emailAddress, 
              resetLinkSent: true
            )
          )
        );
        setState(() {
          isLoading = false;
          isEmailAddressInvalid = false;
        });
      } on Exception catch (e) {
        print('Error: $e');
        setState(() {
          isLoading = false;
          _emailAddressFormKey.currentState.reset();
        });
      }
    } else {
      setState(() {
        isLoading = false;
        isEmailAddressInvalid = true;
      });
    }
  }

}
