import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextInputField extends StatelessWidget {
  final IconData? suffixIcon;
  final String hintText;
  final TextEditingController controller;
  final FocusNode foucsNode;
  final TextInputAction inputAction;
  final FormFieldValidator validator;

  const CustomTextInputField({
    required this.controller,
    required this.validator ,
    required this.foucsNode,
    super.key,
    this.suffixIcon,
    required this.hintText,
    required this.inputAction,

  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator ,
      controller: controller,
      focusNode: foucsNode,
      textInputAction: inputAction,
      cursorColor:  Color(0xffCABBEf),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: const  Color(0xffCABBEf),width: 1.5),
          borderRadius: BorderRadius.circular(5.r),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const  Color(0xffCABBEf), width: 1.5),
          borderRadius: BorderRadius.circular(5.r),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: const Color(0xffCABBEf),width: 1.5),
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    );
  }
}
