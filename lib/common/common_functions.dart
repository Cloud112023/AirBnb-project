import 'package:flutter/material.dart';

class TCommonFunctions {
  TCommonFunctions._();

  static showSnackbar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
