
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
    var response;
    try {
      switch(requestType){
        case RequestType.post:
          final List<Map<String, dynamic>> maps = await db.query('diabetes',
          );
          options.extra['isFromLocal'] = true;
          return Response(requestOptions: options, data: response, statusCode: 200);
        case RequestType.put:
        response =  await db.insert(
          'diabetes',
          jsonDecode(options.data),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        options.extra['isFromLocal'] = true;
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