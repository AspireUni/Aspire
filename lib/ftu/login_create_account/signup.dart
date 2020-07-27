import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../common/global_header.dart';
import '../../constants/common_constants.dart';
import '../../constants/signuplogin_constants.dart';
import '../../models/models.dart';
import '../authentication.dart';
import './login.dart';


class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  String emailAddress, password;
  String _errorMessage;
  bool _isLoading;
  Store<AppState> store;

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
      try {
        await signUp();
        setState(() {
          _isLoading = false;
        });

      } on Exception catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e as String;
          _formKey.currentState.reset();
        });
      }
    } else {
      setState(() {
          _isLoading = false;
        });
    }
  }

  @override
  void initState() {
    super.initState();

    _errorMessage = "";
    _isLoading = false;
    
    store = StoreProvider.of<AppState>(context, listen: false);
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  Future<void> signUp() async {
    await Auth().signUp(emailAddress, password);
    Auth().sendEmailVerification();
    _showVerifyEmailSentDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalHeader(
        actionText: loginAction,
        onActionTap: () => Navigator.pushReplacement(
          context, MaterialPageRoute(
            builder: (context) => Login()
          )
        )
      ),
      body: Stack(
        children: <Widget>[
          _showForm(),
          _showCircularProgress(),
        ],
      )
    );
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
          child: Image.asset('images/logos/light_logo_transparent.png'),
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
        onSaved: (value) => emailAddress = value.trim()
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
        onSaved: (value) => password = value.trim()
      ),
    );
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
          child: Text(
            createAccountButtonPrimary,
            style: TextStyle(fontSize: 20.0, color: Colors.white)
          ),
          onPressed: validateAndSubmit,
        ),
      )
    );
  }
}
