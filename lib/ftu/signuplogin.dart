import 'package:flutter/material.dart';

import '../constants/signuplogin_constants.dart';
import './authentication.dart';


class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  State<StatefulWidget> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = GlobalKey<FormState>();

  String _email, _password, _errorMessage;
  bool _isLoginForm, _isLoading;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          _showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } on Exception catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e as String;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(welcomeMessage),
        ),
        body: Stack(
          children: <Widget>[
            _showForm(),
            _showCircularProgress(),
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(vertifyAccountTitle),
          content: Text(vertifyAccountMessage),
          actions: <Widget>[
            FlatButton(
              child: Text(dissmissMessage),
              onPressed: () {
                toggleFormMode();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _showForm() {
    return Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              showLogo(),
              showEmailInput(),
              showPasswordInput(),
              showPrimaryButton(),
              showSecondaryButton(),
              showErrorMessage(),
            ],
          ),
        ));
  }

  Widget showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.only(top: 70.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('images/Logo.png'),
        ),
      ),
    );
  }

  Widget showEmailInput() {
    return Padding(
      padding: EdgeInsets.only(top: 100.0),
      child: TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: InputDecoration(
            hintText: emailHint,
            icon: Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? emailEmptyMessage : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }

  Widget showPasswordInput() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0),
      child: TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
            hintText: passwordHint,
            icon: Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        validator: (value) => value.isEmpty ? passwordEmptyMessage : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    return FlatButton(
        child: Text(
            _isLoginForm ? createAccountButtonSecondary : haveAccountButton,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: toggleFormMode);
  }

  Widget showPrimaryButton() {
    return Padding(
        padding: EdgeInsets.only(top: 45.0),
        child: SizedBox(
          height: 40.0,
          child: RaisedButton(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            color: Colors.blue,
            child: Text(_isLoginForm ? loginButton : createAccountButtonPrimary,
                style: TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: validateAndSubmit,
          ),
        ));
  }
}
