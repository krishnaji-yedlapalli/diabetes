
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
      if(options.data != null) options.data = jsonDecode(options.data);
      var mobileNumber = options.data != null ? options.data['mobileNumber'] : options.queryParameters['mobileNumber'];
      List<Map> result = await db.rawQuery('SELECT * FROM diabetesreading WHERE mobileNumber=?', [mobileNumber]);
      switch(requestType){
        case RequestType.get :
          response = {
            'dataValue' : result.isNotEmpty ? jsonDecode(result.first['readingData']) : [],
            'message' : 'Success'
          };
          return Response(requestOptions: options, data: response, statusCode: 200);
        case RequestType.post:
          var data;
          if(result.isNotEmpty){
            var readingList = jsonDecode(result.first['readingData']);
             readingList.add(options.data);
            data =  {
              'mobileNumber' : options.data['mobileNumber'],
              'readingData' : jsonEncode(readingList)
            };

          }else{
            data = {
              'mobileNumber' : options.data['mobileNumber'],
               'readingData' : jsonEncode([options.data])
    };

          }
          response =  await db.insert(
            'diabetesreading',
            data,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
          return Response(requestOptions: options, data: {
            'dataValue' : response,
            'message' : "Successfully added"
          }, statusCode: 200);
        default :
          return Response(requestOptions: options, data: response, statusCode: 405, statusMessage: 'Method Not Allowed');
      }
    }catch(e){
      return Response(requestOptions: options, data: response, statusCode: 500, statusMessage: 'Internal Exception');
    }
  }

}