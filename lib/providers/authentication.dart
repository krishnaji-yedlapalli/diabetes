import 'dart:async';
import 'dart:convert';

import 'package:diabetes_tracker/screens/authentication/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repository/authentication_repo.dart';
import '../screens/home.dart';
import '../utils/helper_methods.dart';

class AuthenticationProvider with ChangeNotifier {

  Map? userDetails;

  Future<void> validateLogin(BuildContext context, Map body) async {
    try{
     var response = await AuthenticationRepository().validateLoginCred(body);
     if(response?['dataValue'] != null){
       userDetails = response?['dataValue'];
       setUserDetails(context, userDetails);
       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => HomePage()), (route) => false);
     }else{
       HelperMethods.showSnackBarMessage(context, '${response?['message']}');
     }
    } catch(e,s){
      HelperMethods.showSnackBarMessage(context, '${e.toString()}');
    }
  }


  Future<void> onClickOfRegister(context, Map body) async {
    try{
      var response = await AuthenticationRepository().userRegistration(body);
      if(response?['dataValue'] != null){
        HelperMethods.showSnackBarMessage(context, '${response?['message']}');
        Navigator.pop(context);
      }else{
        HelperMethods.showSnackBarMessage(context, '${response?['message']}');
      }
    } catch(e,s){
      HelperMethods.showSnackBarMessage(context, '${e.toString()}');
    }
  }


  setUserDetails(BuildContext context, Map? userDetails) async {
    final prefs = await SharedPreferences.getInstance();
    if(userDetails == null) {
      prefs.remove('userDetails');
      this.userDetails = null;
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
      return;
    }
    this.userDetails = userDetails;
    prefs.setString('userDetails', jsonEncode(userDetails));
  }

 Future<Map?> getUserDetails() async {
   try {
     final prefs = await SharedPreferences.getInstance();
     if (prefs.containsKey('userDetails')) {
       var userDetails = jsonDecode(prefs.getString('userDetails') ?? '');
       this.userDetails = userDetails;
     }
     return userDetails;
   } catch(e,s){
     return null;
   }
 }
}