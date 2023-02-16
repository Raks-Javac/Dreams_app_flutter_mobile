import 'package:flutter/material.dart';

class SizerClass {
  static bool isDeskTop(BoxConstraints constraints) {
    final boolSize = constraints.minWidth > 520;

    return boolSize;
  }
}
