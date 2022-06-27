
import 'package:diabetes_tracker/services/base_service.dart';
import 'package:flutter/material.dart';

import '../services/urls.dart';
import '../utils/enums.dart';

class AuthenticationRepository with BaseService {


  Future<Map?> validateLoginCred(Map body) async {
    var response = await makeRequest(url: Urls.authenticateLogin, method: RequestType.post, body: body, storeResponseInDb: true);
    return response;
  }

  Future<Map?> userRegistration(Map body) async {
    var response = await makeRequest(url: Urls.registerUser, method: RequestType.post, body: body, storeResponseInDb: true);
    return response;
  }
}