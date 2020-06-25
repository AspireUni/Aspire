import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_fonts/google_fonts.dart';

import 'input_field.dart';

class EditContact extends StatefulWidget {
  final Map contact;
  final String fullName;
  EditContact({Key key, @required this.contact, @required this.fullName}) : super(key: key);

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  ValueChanged _onChanged = (val) => print(val);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: <Widget>[
          InputField(
            labelText: "Full name", 
            formField: buildFullNameField()
          ),
          InputField(
            labelText: "Email address", 
            formField: buildEmailAddressField()
          ),
          InputField(
            labelText: "Phone number", 
            formField: buildPhoneNumberField()
          ),
          InputField(
            labelText: "Website", 
            formField: buildWebsiteField()
          ),
        ],
      )
    );
  }

  buildFullNameField() {
    return FormBuilderTextField(
      attribute: "fullName",
      initialValue: widget.fullName,
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
      onChanged: _onChanged,
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  buildEmailAddressField() {
    return FormBuilderTextField(
      attribute: "emailAddress",
      initialValue: widget.contact["emailAddress"],
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
      onChanged: _onChanged,
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
      initialValue: widget.contact["phoneNumber"],
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
      dialogTitle: Text(
        "Select your phone code:",
        style: GoogleFonts.muli(
          textStyle: TextStyle(
            color: Colors.black, 
            letterSpacing: .5, 
            fontSize: 13.0, 
          )
        )
      ),
      dialogTextStyle: TextStyle(
        color: Colors.red, 
        letterSpacing: .5, 
        fontSize: 13.0, 
      ),
      titlePadding: EdgeInsets.all(0.0),
      isSearchable: false,
      onChanged: _onChanged,
      priorityListByIsoCode: ['CA', 'US'],
      validators: [
        FormBuilderValidators.numeric(
            errorText: 'Enter a valid phone number.'),
      ],
      keyboardType: TextInputType.phone,
    );
  }

  buildWebsiteField() {
    return FormBuilderTextField(
      attribute: "website",
      initialValue: widget.contact["website"],
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
      onChanged: _onChanged,
      validators: [
        FormBuilderValidators.url(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.url,
    );
  }
  
}
