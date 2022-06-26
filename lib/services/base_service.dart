import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';

import '../utils/enums.dart';
import '../utils/global_variables.dart';
import 'urls.dart';

class BaseService {
  Future<dynamic> makeRequest<T>(
      {required String url,
      String? baseUrl,
      dynamic body,
      String? contentType,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      RequestType method = RequestType.get,
        Map<String, dynamic> extras = const {}, bool storeResponseInDb = false}) async {

    dio.options.baseUrl = baseUrl ?? Urls.baseUrl;
    dio.options.headers[HttpHeaders.contentTypeHeader] = 'text/xml';
    dio.options.extra.addAll(extras);
    dio.options.extra['storeResponse'] = storeResponseInDb;
    if(headers != null) dio.options.headers.addAll(headers);

    Response response;
      switch (method) {
        case RequestType.get:
          if (queryParameters != null && queryParameters.isNotEmpty) {
            response = await dio.get(
              url,
              queryParameters: queryParameters,
            );
            return response.data;
          }
          response = await dio.get(url);
          return response.data;
        case RequestType.put:
          response = await dio.put(url,
              queryParameters: queryParameters, data: body);
          return response.data;
        case RequestType.post:
          response = await dio.post(
            url,
            queryParameters: queryParameters,
            data: jsonEncode(body),
          );
          return response.data;
        case RequestType.delete:
          response = await dio.delete(url,
              queryParameters: queryParameters, data: body);
          return response.data;
      }
    }
  }
