import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customButton({
  required String name,
  required VoidCallback onPressed,
  Color? foregroundColor,
  double? radius,
}) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 5.r),
        ),
        backgroundColor: Color(0xffCABBEf),
        foregroundColor: foregroundColor ?? Colors.black,
        minimumSize: Size(200, 45),
        textStyle: TextStyle(fontSize: 20),
      ),
      onPressed: onPressed,
      child: Text(name),
    ),
  );
}
