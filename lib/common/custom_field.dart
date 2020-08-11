import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'common.dart';

class CustomField extends StatelessWidget {
  final String attribute;
  final String initialValue;
  final bool isFocused;
  final bool isEnabled;
  final bool isInvalid;
  final String hintText;
  final IconData icon;
  final String value;
  final void Function() onTap;

  CustomField({
    Key key,
    @required this.attribute,
    @required this.initialValue,
    @required this.isFocused,
    @required this.isEnabled,
    @required this.isInvalid,
    @required this.hintText,
    @required this.icon,
    @required this.value,
    @required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isEnabled ? FormBuilderCustomField(
      attribute: attribute,
      initialValue: initialValue,
      validators: [
        FormBuilderValidators.required(),
      ],
      formField: FormField(
        builder: buildFormField
      )
    ) : SizedBox();
  }

  Widget buildFormField(FormFieldState<dynamic> field) {
    return InputDecorator(
      isFocused: isFocused,
      decoration: fieldDecoration(
        isFocused: isFocused,
        isInvalid: isInvalid,
        icon: icon,
        errorText: field.errorText
      ),
      baseStyle: fieldTextStyle(color: ThemeColors.primary),
      child: Container(
        height: 20.0,
        child: InkWell(
          onTap: onTap,
          child: FormatText(
            text: value == '' || value == null ? hintText : value,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            overflow: TextOverflow.ellipsis,
            textColor: value == '' || value == null
                ? Colors.grey
                : ThemeColors.primary
          ),
        )
      ),
    );
  }
}
