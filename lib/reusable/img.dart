import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget image({required String img, double? height = 140, double? width = 140}) {
  return Image.network(
    img,
    height: height,
    width: width,
    fit: BoxFit.cover,
    errorBuilder:
        (context, error, stackTrace) => Container(
          color: Colors.white12,
          height: 80.h,
          width: 80.w,
          child: Icon(Icons.music_note),
        ),
  );
}

Widget imgAvatar({required String img}) {
  return SizedBox(
    width: 80,
    height: 80,
    child: ClipOval(
      child: Image.network(
        img,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: Colors.white12,
            alignment: Alignment.center,
            child: Icon(
              Icons.music_note,
              size: 40,
              color: Colors.grey,
            ),
          );
        },
      ),
    ),
  );
}

