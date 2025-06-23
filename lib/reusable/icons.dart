import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget svgImg({
  required String img,
  required double height,
  required double width,
}) {
  return SvgPicture.asset(img, height: height, width: width);
}
