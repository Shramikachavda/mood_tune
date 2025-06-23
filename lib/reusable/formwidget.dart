import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mood_tune/reusable/text_form_field.dart';

Widget formWidget({
  required String text,
  required String hintText,
  required TextEditingController controller,
  required FocusNode focusNode,
  required FormFieldValidator validator,
  TextInputAction inputAction = TextInputAction.next,
  IconData? suffixIcon,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22.sp),
      ),
      SizedBox(height: 8.h),
      CustomTextInputField(
        validator: validator,
        controller: controller,
        foucsNode: focusNode,
        inputAction: inputAction,
        hintText: hintText,
        suffixIcon: suffixIcon,
      ),
    ],
  );
}
