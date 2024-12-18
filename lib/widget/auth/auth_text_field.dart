import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../infrastructure/theme/themes.dart';

class AuthTextField extends StatelessWidget {
  final Key? formKey;
  final Function()? onTap;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? hintText;
  final bool? isObsecure;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? formatter;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final bool? readOnly;

  AuthTextField({
    Key? key,
    this.formKey,
    this.onTap,
    this.onChanged,
    this.validator,
    this.hintText,
    this.isObsecure,
    this.suffixIcon,
    this.formatter,
    this.keyboardType,
    this.controller,
    this.readOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: TextFormField(
        style: tsBodySmallMedium(black.withOpacity(0.8)),
        onTap: onTap,
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        obscureText: isObsecure ?? false,
        readOnly: readOnly ?? false,
        inputFormatters: formatter,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
            isCollapsed: true,
            isDense: true,
            contentPadding: EdgeInsets.all(defaultMargin),
            hintText: hintText,
            hintStyle: tsBodySmallRegular(darkGrey),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: secondaryColor, width: 2)),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: lightGrey, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: warningColor, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            suffixIcon: suffixIcon),
      ),
    );
  }
}
