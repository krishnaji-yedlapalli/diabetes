import 'package:flutter/material.dart';

mixin CommonMixin {

  String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Password is required';
    }
    return null;
  }

  String? firstNameValidator(String? value) {
    if (value!.isEmpty) {
      return 'First Name is required';
    }
    return null;
  }

  String? lastNameValidator(String? value) {
    if (value!.isEmpty) {
      return 'Last Name is required';
    }
    return null;
  }

  String? ageValidator(String? value) {
    if (value!.isEmpty) {
      return 'Age is required';
    }
    return null;
  }

  String? mobileNumberValidator(String? value) {
    if (value!.isEmpty) {
      return 'Mobile Number is required';
    }
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digits';
    } else
      return null;
  }

  String? decimalValueValidator(String? value) {
    if (value!.isEmpty) {
      return 'Value is required';
    }
    return null;
  }

  DropdownMenuItem dropDownMenuItems(String id, String value) {
    return DropdownMenuItem(
      value: id,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          '$value',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}