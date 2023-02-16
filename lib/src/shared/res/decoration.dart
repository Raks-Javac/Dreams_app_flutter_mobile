import 'package:flutter/material.dart';

abstract class AppDecoration {
  static OutlineInputBorder get textFieldDecoration {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(width: 0.0, color: Colors.transparent),
    );
  }
}
