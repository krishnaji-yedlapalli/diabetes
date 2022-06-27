import 'dart:async';

import 'package:diabetes_tracker/repository/diabetes_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/reading.dart';
import '../utils/helper_methods.dart';
import 'authentication.dart';

class DiabetesProvider with ChangeNotifier {

  late StreamController<List<Reading>> readingStreamController;
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

  @override
  dispose(){
    super.dispose();
    readingStreamController.close();
  }

  Future<void> addReading(BuildContext context, Map body) async {

    try{
      body.addAll({
        'mobileNumber' : Provider.of<AuthenticationProvider>(context, listen:  false).userDetails?['mobileNumber'],
        'mealType' : _selectedDropDownId,
        'dateTime' : DateTime.now().toString()
      });
      var response = await DiabetesRepository().addReading(body);
      HelperMethods.showSnackBarMessage(context, '${response?['message']}');
      if(response?['dataValue'] != null){
        Navigator.pop(context);
        return;
      }
    } catch(e,s){

    }
  }

  Future<void> fetchReading(BuildContext context) async {
    try{
      Map<String, dynamic> query = {
        'mobileNumber' : Provider.of<AuthenticationProvider>(context, listen:  false).userDetails?['mobileNumber'],
      };
      var response = await DiabetesRepository().fetchReadings(query);
      response = response.reversed.toList();
      readingStreamController.add(response);
    } catch(e,s){
      readingStreamController.addError(e.toString());
    }
  }

  void onChangeOfDropDown(BuildContext context, String id) {
    setDropDownId = id;
    print(id);
    notifyListeners();
  }

  set setDropDownId(String? id) {
    _selectedDropDownId = id;
    notifyListeners();
  }

  clearDropDown(){
    _selectedDropDownId = null;
  }
}