import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../common/styles.dart';

class PickerField extends StatelessWidget {
  final String attribute;
  final String initialValue;
  final bool isFocused;
  final bool isEnabled;
  final String value;
  final void Function() onTap;

  PickerField({
    Key key,
    @required this.attribute,
    @required this.initialValue,
    @required this.isFocused,
    @required this.isEnabled,
    @required this.value,
    @required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderCustomField(
      attribute: attribute,
      initialValue: initialValue,
      validators: [
        FormBuilderValidators.required(),
      ],
      formField: FormField(
        builder: (field) {
          return InputDecorator(
            isFocused: isFocused,
            decoration: fieldDecoration(errorText: field.errorText),
            baseStyle: fieldTextStyle,
            child: Container(
              height: 20.0,
              child: InkWell(
                onTap: isEnabled ? onTap : null,
                child: Text(
                  value,
                  style: labelTextStyle(isEnabled: isEnabled),
                ),
              )
            ),
          );
        }
      )
    );
  }
}
