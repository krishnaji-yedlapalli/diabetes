
import 'package:diabetes_tracker/models/reading.dart';
import 'package:diabetes_tracker/services/base_service.dart';
import 'package:flutter/material.dart';

import '../services/urls.dart';
import '../utils/enums.dart';

class DiabetesRepository with BaseService {


  Future<Map?> addReading(Map body) async {
    var response = await makeRequest(url: Urls.diabetesReading, method: RequestType.post, body: body, storeResponseInDb: true);
    return response;
  }

  Future<List<Reading>> fetchReadings(Map<String, dynamic> query) async {
    var list = <Reading>[];
    var response = await makeRequest(url: Urls.diabetesReading, method: RequestType.get, queryParameters: query, storeResponseInDb: true);
   if(response['dataValue'] != null){
     list = response['dataValue'].map<Reading>((e) => Reading.fromJson(e)).toList();
   }
    return list;
  }
}