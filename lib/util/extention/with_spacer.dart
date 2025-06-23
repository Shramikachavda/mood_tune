import 'package:flutter/material.dart';

extension Separators on List<Widget> {
  List<Widget> withSeparator(Widget separator) {
    if (length <= 1) return this;

    final separated = <Widget>[];
    for (int i = 0; i < length; i++) {
      separated.add(this[i]);
      if (i < length - 1) separated.add(separator);
    }
    return separated;
  }
}