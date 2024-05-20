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

  AuthTextField({
    this.formKey,
    this.onTap,
    this.onChanged,
    this.validator,
    this.hintText,
    this.isObsecure,
    this.suffixIcon,
    this.formatter,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: formKey,
      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      obscureText: isObsecure ?? false,
      inputFormatters: formatter,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
          isCollapsed: true,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          hintText: hintText,
          hintStyle: tsBodySmallMedium(darkGrey),
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
    );
  }
}
