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


class SaveContact extends StatefulWidget {
  SaveContact({Key key}) : super(key: key);

  @override
  _SaveContactState createState() => _SaveContactState();
}

class _SaveContactState extends State<SaveContact> {

  Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    store = StoreProvider.of<AppState>(context);

    return StoreConnector<AppState, SaveProfileState>(
      converter: saveProfileStateSelector,
      builder: (context, state) => Container(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: <Widget>[
            InputField(
              labelText: editContactFullname, 
              formField: buildFullNameField(state.fullName)
            ),
            InputField(
              enabled: false,
              labelText: editContactEmailAddress, 
              formField: buildEmailAddressField(state.emailAddress)
            ),
            InputField(
              labelText: editContactPhoneNumber, 
              formField: buildPhoneNumberField(state.phoneNumber)
            ),
            InputField(
              labelText: editContactWebsite, 
              formField: buildWebsiteField(state.website)
            ),
          ],
        )
      )
    );
  }

  buildFullNameField(String fullName) {
    return FormBuilderTextField(
      attribute: 'fullName',
      initialValue: fullName,
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => store.dispatch(UpdateFullName(value)),
      validators: [
        FormBuilderValidators.required(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.text,
    );
  }

  buildEmailAddressField(String emailAddress) {
    return FormBuilderTextField(
      readOnly: true,
      attribute: 'emailAddress',
      initialValue: emailAddress,
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

  buildPhoneNumberField(String phoneNumber) {
    return FormBuilderPhoneField(
      attribute: 'phoneNumber',
      initialValue: phoneNumber,
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      dialogTitle: Text(
        phoneNumberDialogTitle,
        style: fieldTextStyle
      ),
      titlePadding: EdgeInsets.all(0.0),
      isSearchable: false,
      onChanged: (value) => store.dispatch(UpdatePhoneNumber(value)),
      defaultSelectedCountryIsoCode: isoCodeCA,
      priorityListByIsoCode: [isoCodeCA, isoCodeUS],
      validators: [FormBuilderValidators.numeric(
        errorText: invalidPhoneNumberErrorMessage)
      ],
      keyboardType: TextInputType.phone,
    );
  }

  buildWebsiteField(String website) {
    return FormBuilderTextField(
      attribute: 'website',
      initialValue: website,
      decoration: fieldDecoration(),
      style: fieldTextStyle,
      onChanged: (value) => store.dispatch(UpdateWebsite(value)),
      validators: [
        FormBuilderValidators.url(),
        FormBuilderValidators.maxLength(100),
      ],
      keyboardType: TextInputType.url,
    );
  }
  
}
