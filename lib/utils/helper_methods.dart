
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HelperMethods {

  static const kQuoteReplacer = "¿*¿*¿*¿*";

  static T? enumFromString<T>(Iterable<T> values, String value) {
    return values.firstWhere((type) => type.toString().split(".").last == value);
  }

  static showSnackBarMessage(BuildContext context, String label) {
    var snackBar = SnackBar(
      content: Text(label),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}