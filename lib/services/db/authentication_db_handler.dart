
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

import '../../utils/enums.dart';
import '../../utils/helper_methods.dart';
import '../urls.dart';
import '../utils/abstract_db_handler.dart';

class AuthenticationDbHandler extends DbHandler{

  factory AuthenticationDbHandler() {
    return _singleton;
  }

  AuthenticationDbHandler._internal();

  static final AuthenticationDbHandler _singleton = AuthenticationDbHandler._internal();
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
      options.data = jsonDecode(options.data);
      switch(requestType){
        case RequestType.post:
          List<Map> result = await db.rawQuery('SELECT * FROM diabetesauth WHERE mobileNumber=?', [options.data?['mobileNumber']]);
          switch(options.path){
            case Urls.authenticateLogin :
              if(result.isEmpty || result.first['password'] != options.data['password']) return Response(requestOptions: options, data: {"dataValue" : null, "message" : "User doesn't exists or Invalid Password"}, statusCode: 401);
              else return Response(requestOptions: options, data: {"dataValue" : result.first as Map<String, dynamic> }, statusCode: 200);
            case Urls.registerUser :
              if(result.isNotEmpty) return Response(requestOptions: options, data: {"dataValue" : null, "message" : "User Already exists"}, statusCode: 409);
              var data = options.data as Map<String, Object?>;
              response =  await db.insert(
                'diabetesauth',
                data,
                conflictAlgorithm: ConflictAlgorithm.replace,
              );
              return Response(requestOptions: options, data: {"dataValue" : data, "message" : "Successfully Registered"}, statusCode: 200);
          }
          final List<Map<String, dynamic>> maps = await db.query('diabetes',
          );
          options.extra['isFromLocal'] = true;
          return Response(requestOptions: options, data: response, statusCode: 200);
        default :
          return Response(requestOptions: options, data: response, statusCode: 405, statusMessage: 'Method Not Allowed');
      }
    }catch(e){
      return Response(requestOptions: options, data: response, statusCode: 500, statusMessage: 'Internal Exception');
    }
  }

}