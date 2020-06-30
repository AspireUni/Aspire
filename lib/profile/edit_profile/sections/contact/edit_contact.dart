import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../constants/profile_constants.dart';
import '../../../common/input_field.dart';
import '../../../common/styles.dart';

class EditContact extends StatefulWidget {
  final Map contact;
  final String fullName;
  
  EditContact({Key key, @required this.contact, @required this.fullName}) : super(key: key);

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {

  String fullName;
  Map<String, Object> contact;

  @override
  void initState() {
    super.initState();

    // Temporary workaround until we use global state management
    fullName = widget.fullName;
    contact = {
      'emailAddress': widget.contact['emailAddress'],
      'phoneNumber': widget.contact['phoneNumber'],
      'website': widget.contact['website'],
    };
    
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          InputField(
            labelText: editContactFullname, 
            formField: buildFullNameField()
          ),
          InputField(
            labelText: editContactEmailAddress, 
            formField: buildEmailAddressField()
          ),
          InputField(
            labelText: editContactPhoneNumber, 
            formField: buildPhoneNumberField()
          ),
          InputField(
            labelText: editContactWebsite, 
            formField: buildWebsiteField()
          ),
        ],
      )
    );
  }

  buildFullNameField() {
    return FormBuilderTextField(
      attribute: 'fullName',
      initialValue: fullName,
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => setState(() { fullName = value as String; }),
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  buildEmailAddressField() {
    return FormBuilderTextField(
      attribute: 'emailAddress',
      initialValue: contact['emailAddress'],
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => setState(() { contact['emailAddress'] = value as String; }),
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.emailAddress,
    );
  }

  buildPhoneNumberField() {
    return FormBuilderPhoneField(
      attribute: 'phoneNumber',
      initialValue: contact['phoneNumber'],
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      dialogTitle: Text(
        phoneNumberDialogTitle,
        style: fieldTextStyle
      ),
      titlePadding: EdgeInsets.all(0.0),
      isSearchable: false,
      onChanged: (value) => setState(() { contact['phoneNumber'] = value as String; }),
      priorityListByIsoCode: [isoCodeCA, isoCodeUS],
      validators: [FormBuilderValidators.numeric(errorText: invalidPhoneNumberErrorMessage)],
      keyboardType: TextInputType.phone,
    );
  }

  buildWebsiteField() {
    return FormBuilderTextField(
      attribute: 'website',
      initialValue: contact['website'],
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => setState(() { contact['website'] = value as String; }),
      validators: [
        FormBuilderValidators.url(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.url,
    );
  }
  
}
