

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../utils/enums.dart';
import '../urls.dart';
import 'authentication_db_handler.dart';
import 'diabetes_db_handler.dart';

class OfflineApiHandler {

  factory OfflineApiHandler() {
    return _singleton;
  }

  OfflineApiHandler._internal();

  static final OfflineApiHandler _singleton = OfflineApiHandler._internal();
  Future<Database>? _dataBase;

  Future<Response> requestSegregation(RequestOptions options) async {
    await initiateDataBase();
   switch(options.path){
     case Urls.authenticateLogin: case Urls.registerUser:
       return await AuthenticationDbHandler().executeDbOperations(options, _dataBase!);
     case Urls.diabetesReading:
       return await DiabetesDbHandler().executeDbOperations(options, _dataBase!);
     default:
       throw DioError(requestOptions: options, type: DioErrorType.other, error: 'Not a valid service');
   }
   return Response(requestOptions: options);
  }

  Future initiateDataBase() async {
    _dataBase ??= openDatabase(
      join(await getDatabasesPath(), 'diabetes.db'),
      onCreate: (db, version) async {
        await db.execute(
            'CREATE TABLE diabetesauth (mobileNumber INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, age INTEGER, gender TEXT, password TEXT)');
      },
      version: 1,
    );
  }
}