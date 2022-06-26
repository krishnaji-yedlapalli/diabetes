
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../utils/enums.dart';
import '../../utils/helper_methods.dart';
import '../utils/abstract_db_handler.dart';

class DiabetesDbHandler extends DbHandler{

  factory DiabetesDbHandler() {
    return _singleton;
  }

  DiabetesDbHandler._internal();

  static final DiabetesDbHandler _singleton = DiabetesDbHandler._internal();
  late Future<Database> _dataBase;

  @override
  Future<Response> executeDbOperations(RequestOptions options, Future<Database> dataBase) async {
   _dataBase = dataBase;
   return await performCrudOperation(options);
  }

  @override
  Future<Response> performCrudOperation(RequestOptions options) async {
    Database db = await _dataBase;
    var requestType = HelperMethods.enumFromString(RequestType.values, options.method.toLowerCase());
    options.extra['isFromLocal'] = true;
    var response;
    try {
      switch(requestType){
        case RequestType.get :
          List<Map> result = await db.rawQuery('SELECT * FROM my_table WHERE mobileNumber=?', [options.data['mobileNumber']]);
          response = {
            'dataValue' : result,
            'message' : 'Success'
          };
          return Response(requestOptions: options, data: response, statusCode: 200);
        case RequestType.post:
          response =  await db.insert(
            'diabetes',
            jsonDecode(options.data),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          return Response(requestOptions: options, data: response, statusCode: 200);
        break;
        default :
          return Response(requestOptions: options, data: response, statusCode: 405, statusMessage: 'Method Not Allowed');
      }
    }catch(e){
      return Response(requestOptions: options, data: response, statusCode: 500, statusMessage: 'Internal Exception');
    }
  }

}