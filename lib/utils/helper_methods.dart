
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelperMethods {

  static T? enumFromString<T>(Iterable<T> values, String value) {
    return values.firstWhere((type) => type.toString().split(".").last == value);
  }

  static showSnackBarMessage(BuildContext context, String label, {Color? backgroundColor}) {
    var snackBar = SnackBar(
      content: Text(label),
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}