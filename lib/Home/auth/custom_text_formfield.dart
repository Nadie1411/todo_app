import 'package:flutter/material.dart';
import 'package:todo_app/app_colors.dart';

class CustomTextFormfield extends StatelessWidget {
  String label;
  TextEditingController controller;
  TextInputType keyboardType;
  bool obscureText;
  String? Function(String?)? validator;

  CustomTextFormfield(
      {required this.label,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: label,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.primaryColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.primaryColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: AppColors.redColor)),
            errorMaxLines: 4),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
