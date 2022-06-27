import 'package:diabetes_tracker/repository/diabetes_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication.dart';

class DiabetesProvider with ChangeNotifier {

  List dropDownItems = [
    {
      'id' : 'beforeMeals',
      'name' : 'Before Meals'
    },
    {
      'id' : 'afterMeals',
      'name' : 'After Meals'
    }
  ];

  String? _selectedDropDownId;

  String? get getDropDownId => _selectedDropDownId;


  Future<void> addReading(BuildContext context, Map body) async {

    try{
      body.addAll({
        'mobileNumber' : Provider.of<AuthenticationProvider>(context, listen:  false).userDetails?['mobileNumber'],
        'mealType' : _selectedDropDownId,
        'dateTime' : DateTime.now().toString()
      });
      var response = await DiabetesRepository().addReading(body);
      if(response != null){
        print('error');
      }
    } catch(e,s){

    }
  }

  Future<void> fetchReading(Map query) async {
    try{
      var response = await DiabetesRepository().fetchReadings(query);
    } catch(e,s){

    }
  }

  void onChangeOfDropDown(BuildContext context, String id) {
    setDropDownId = id;
    print(id);
    notifyListeners();
  }

  set setDropDownId(String id) {
    _selectedDropDownId = id;
    notifyListeners();
  }
}