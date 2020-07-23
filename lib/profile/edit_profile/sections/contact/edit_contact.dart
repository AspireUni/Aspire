import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../../../../actions/actions.dart';
import '../../../../constants/profile_constants.dart';
import '../../../../models/models.dart';
import '../../../../selectors/selectors.dart';
import '../../../common/input_field.dart';
import '../../../common/styles.dart';


class EditContact extends StatefulWidget {
  EditContact({Key key}) : super(key: key);

  @override
  _EditContactState createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {

  Store<AppState> store; 

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    return StoreConnector<AppState, Contact>(
      converter: contactSelector,
      builder: (context, contact) => Container(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: <Widget>[
            InputField(
              labelText: editContactFullname, 
              formField: buildFullNameField()
            ),
            InputField(
              enabled: false,
              labelText: editContactEmailAddress, 
              formField: buildEmailAddressField(contact)
            ),
            InputField(
              labelText: editContactPhoneNumber, 
              formField: buildPhoneNumberField(contact)
            ),
            InputField(
              labelText: editContactWebsite, 
              formField: buildWebsiteField(contact)
            ),
          ],
        )
      )
    );
  }

  buildFullNameField() {
    return StoreConnector<AppState, User>(
      converter: userSelector,
      builder: (context, user) => FormBuilderTextField(
        attribute: 'fullName',
        initialValue: user.fullName,
        decoration: fieldDecoration(),
        style: fieldTextStyle,
        onChanged: (value) => store.dispatch(UpdateFullName(value)),
        validators: [
          FormBuilderValidators.required(),
          FormBuilderValidators.maxLength(100),
        ],
        keyboardType: TextInputType.text,
      )
    );
  }

  buildEmailAddressField(Contact contact) {
    return FormBuilderTextField(
      readOnly: true,
      attribute: 'emailAddress',
      initialValue: contact.emailAddress,
      decoration: fieldDecoration(),
      style: labelTextStyle(isEnabled: false),
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.email(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.emailAddress,
    );
  }

  buildPhoneNumberField(Contact contact) {
    return FormBuilderPhoneField(
      attribute: 'phoneNumber',
      initialValue: contact.phoneNumber,
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      dialogTitle: Text(
        phoneNumberDialogTitle,
        style: fieldTextStyle
      ),
      titlePadding: EdgeInsets.all(0.0),
      isSearchable: false,
      onChanged: (value) => store.dispatch(
        UpdateContact(
          contact.copyWith(
            phoneNumber: value
          )
        )
      ),
      priorityListByIsoCode: [isoCodeCA, isoCodeUS],
      validators: [FormBuilderValidators.numeric(
        errorText: invalidPhoneNumberErrorMessage)
      ],
      keyboardType: TextInputType.phone,
    );
  }

  buildWebsiteField(Contact contact) {
    return FormBuilderTextField(
      attribute: 'website',
      initialValue: contact.website,
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => store.dispatch(
        UpdateContact(
          contact.copyWith(
            website: value
          )
        )
      ),
      validators: [
        FormBuilderValidators.url(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.url,
    );
  }
  
}
