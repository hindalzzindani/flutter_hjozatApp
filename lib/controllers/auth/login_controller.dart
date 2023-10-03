import 'dart:convert';
import '../../common/ctm_alert_widget.dart';
import '../../local_db_sqflite/db_helper_local.dart';
import '../../repository/auth_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetConnect {
  loginCTR(Map<String, String> loginMap) {
    AuthRepository().loginRep(loginMap).then((resValue) async {
      var bodyMap = json.decode(resValue.body);
      print('login res :' + bodyMap.toString());
      if (bodyMap['status'] == "success") {
        if (bodyMap['response'] == 200) {
          if (bodyMap['data'] != null) {
            print(bodyMap['data']);
            var token = bodyMap['data'];

            DBHelper01.setStore('token', token);
            DBHelper01.setStore('userid', token);
            DBHelper01.setStore('password', token);
          }
        }
      }
      // else {
      //   CtmAlertDialog.apiServerErrorAlertDialog('غير متصل', '');
      // }
    }).onError((error, stackTrace) {
      print('Error :' + error.toString());
      print('stackTrace :' + stackTrace.toString());
      CtmAlertDialog.apiServerErrorAlertDialog(
          'Server Error :', error.toString());
    });
  }
}
