import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';

class FiturTextField extends StatelessWidget {
  final Key? key;
  final String? hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  FiturTextField(
      {this.key,
      this.hintText,
      this.onChanged,
      this.validator,
      this.keyboardType,
      this.inputFormatters,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: tsBodySmallRegular(black),
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: tsBodySmallMedium(darkGrey),
        fillColor: lightGrey,
        filled: true,
        isCollapsed: true,
        isDense: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: secondaryColor, width: 2),
            borderRadius: BorderRadius.circular(10)),
      ),
      onChanged: onChanged,
      validator: validator,
    );
  }
}
