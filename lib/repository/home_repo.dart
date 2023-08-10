import 'dart:convert';

import 'package:diabetes_tracker/models/home_model.dart';
import 'package:diabetes_tracker/services/base_service.dart';
import 'package:diabetes_tracker/variants/variant_config.dart';
import 'package:diabetes_tracker/variants/variants.dart';
import '../services/urls.dart';
import '../utils/enums.dart';

class HomeRepository with BaseService {
  Future<HomeDetailsModel?>? getData() async {
    bool isWire = true;
    Map<String, dynamic> query = {
      "q": (Variant().varConfig?.isWire ?? true)
          ? "the wire characters"
          : "simpsons characters",
      "format": "json"
    };
    HomeDetailsModel? homeDetails;
    var response = await makeRequest(
        url: '',
        baseUrl: Urls.baseUrl,
        queryParameters: query,
        method: RequestType.get);
    if (response != null) {
      homeDetails = HomeDetailsModel.fromJson(jsonDecode(response));
    }
    return homeDetails;
  }
}
