
import 'package:diabetes_tracker/services/base_service.dart';
import 'package:flutter/material.dart';

import '../services/urls.dart';
import '../utils/enums.dart';

class DiabetesRepository with BaseService {


  Future<bool> addReading(Map body) async {
    var status = false;
    var response = await makeRequest(url: Urls.diabetesReading, method: RequestType.post, body: body, storeResponseInDb: true);
    if(response['dataValue'] != null){
      status = true;
    }
    return status;
  }

  Future<bool> fetchReadings(Map body) async {
    var status = false;
    var response = await makeRequest(url: Urls.diabetesReading, method: RequestType.get, body: body, storeResponseInDb: true);
    if(response['dataValue'] != null){
      status = true;
    }
    return status;
  }
}