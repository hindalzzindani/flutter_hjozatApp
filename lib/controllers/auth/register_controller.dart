import 'dart:convert';

import '../../common/ctm_alert_widget.dart';
import '../../repository/auth_repository.dart';
import 'package:get/get.dart';

class RegisterController extends GetConnect{

  registerCTR(Map<String, String> registerMap) {
    AuthRepository().loginRep(registerMap).then((resValue) async {
      var bodyMap = json.decode(resValue.body);

      print('Register response :' + bodyMap.toString());

        if (bodyMap['status'] == "success") {
          if (bodyMap['response'] == 200) {
            if (bodyMap['data'] != null) {
              print(bodyMap['data']);
            }
          }
        }else{
          CtmAlertDialog.apiServerErrorAlertDialog('Server Error :','');
        }

    }).onError((error, stackTrace) {
      print('Error :' + error.toString());
      print('stackTrace :' + stackTrace.toString());
      CtmAlertDialog.apiServerErrorAlertDialog('Server Error :',error.toString());
    });
  }
}