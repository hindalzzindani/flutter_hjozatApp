import 'dart:io';

import 'package:get_storage/get_storage.dart';

import '../local_db_sqflite/db_helper.dart';
import '../local_db_sqflite/db_helper_local.dart';

class RestApiStatus {
  var token= DBHelper01.getToken('token');
  static Map<String, String> headerMap = {
    HttpHeaders.contentTypeHeader: 'application/json'
  };

   Map<String, String> headerMapWithToken = {
  "Authorization": 'Bearer ${GetStorage(DbStrings.dbName).read("token")}',
    HttpHeaders.contentTypeHeader: "application/json"
  };

  static int successStatusCode = 200;
  static int errorStatusCode = 401;
  static String errorStatusMessage = "";
}
