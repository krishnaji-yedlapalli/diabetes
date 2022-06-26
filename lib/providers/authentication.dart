import 'package:flutter/material.dart';

import '../repository/authentication_repo.dart';
import '../screens/home.dart';
import '../utils/helper_methods.dart';

class AuthenticationProvider with ChangeNotifier {


  Future<void> validateLogin(BuildContext context, Map body) async {
    try{
     var response = await AuthenticationRepository().validateLoginCred(body);
     if(response?['dateVale'] != null){
       Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
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
      if(response?['dateVale'] != null){
        Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      }else{
        HelperMethods.showSnackBarMessage(context, '${response?['message']}');
      }
    } catch(e,s){
      HelperMethods.showSnackBarMessage(context, '${e.toString()}');

    }
  }
}