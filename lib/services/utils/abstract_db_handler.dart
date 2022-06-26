

import 'package:dio/dio.dart';
import 'package:sqflite/sqflite.dart';

abstract class DbHandler {
  Future<Response> executeDbOperations(RequestOptions options, Future<Database> dataBase);
  Future<Response> performCrudOperation(RequestOptions options);
}