
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoreDataHolder {

  factory CoreDataHolder() {
    return _singleton;
  }

  CoreDataHolder._internal();

  static final CoreDataHolder _singleton = CoreDataHolder._internal();

  var userNameCtrl = TextEditingController();
  var pwdCtrl = TextEditingController();
  var dateCtrl = TextEditingController();
  Map? userDetails;
  Map? appointmentData;

  onChangeOfData([value]) async {
     final prefs = await SharedPreferences.getInstance();
     var userDetails = {
       'userName' : userNameCtrl.text.trim(),
       'password' : pwdCtrl.text.trim(),
       'date' : dateCtrl.text.trim()
     };
     this.userDetails = userDetails;
     prefs.setString('userDetails', jsonEncode(userDetails));
   }

   getLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    if(prefs.containsKey('userDetails')){
      var userDetails = jsonDecode(prefs.getString('userDetails') ?? '');
      if(userDetails is Map){
        this.userDetails = userDetails;
        userNameCtrl.text = userDetails['userName'];
        pwdCtrl.text = userDetails['password'];
        dateCtrl.text = userDetails['date'];
      }
    }
  }

  // set setData(Map? data){
  //   appointmentData = data;
  // }
}