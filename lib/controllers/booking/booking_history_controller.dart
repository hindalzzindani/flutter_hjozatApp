import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_hjozatapp/local_db_sqflite/db_helper_local.dart';
import 'package:flutter_hjozatapp/repository/auth_repository.dart';

import '../../common/ctm_alert_widget.dart';
import '../../models/booking_history_model.dart';
import '../../repository/booking_repository.dart';
import 'package:get/get.dart';

class BookingHistoryController extends GetConnect {
  @override
  void onInit() {
    super.onInit();
    print(' Booking History');
/*
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingHistoryCTR();
    });
*/
  }

  RxList<BookingHistoryModel> bookingHistoryList =
      List<BookingHistoryModel>.empty(growable: true).obs;
  RxBool isDataLoading = false.obs;

  bookingHistoryCTR() {
    isDataLoading.value = false;
    bookingHistoryList.clear();
    BookingRepository().bookingTicketHistoryRep().then((resValue) async {
      var bodyMap = json.decode(resValue.body);
      print(' Booking history response  : ' + bodyMap.toString());

      if (bodyMap['status'] == "success") {
        if (bodyMap['response'] == 200) {
          if (bodyMap['data'] != null) {
            print(bodyMap['data']);
            for (var history in bodyMap['data']) {
              bookingHistoryList.add(BookingHistoryModel.fromJson(history));
            }
            print('Booking Id:' + bookingHistoryList[0].id.toString());
            print('lng Country :' + bookingHistoryList.length.toString());
            isDataLoading.value = true;
          }
        }
      } else {
        isDataLoading.value = true;
      } /*else if(bodyMap['status'] == "fail"){
       if (bodyMap['response'] == 201 && bodyMap['data'].toString().toLowerCase()!='No ticket found') {
        var email=DBHelper01.getToken('userid').toString();
        var password= DBHelper01.getToken('password').toString();
        Map<String, String> loginMap = {
          "userid":email,
          "password":password,
          "type": "mobile",
        };
        AuthRepository().loginRep(loginMap).then((resValue) async {
          var bodyMap = json.decode(resValue.body);

          var resCode = resValue.statusCode;
          print('bodyMap login bc'+bodyMap.toString());
          if (resCode == 200 || resCode == 201 || resCode == 202) {
            if (bodyMap['status'] == "success") {
              if (bodyMap['response'] == 200) {
                if (bodyMap['data'] != null) {
                  print(bodyMap['data']);
                  var token = bodyMap['data'];

                  DBHelper01.setStore('token', token);
                  DBHelper01.getToken('token');
                  DBHelper01.setStore('userid', email);
                  DBHelper01.setStore('password', password);
                  bookingHistoryCTR();
                }}}}
        }).onError((error, stackTrace) {
          print('Error :' + error.toString());
          print('stackTrace :' + stackTrace.toString());
          CtmAlertDialog.apiServerErrorAlertDialog('خطأ في الاتصال :',error.toString());
        });
      }
      }*/
      // else {
      //   CtmAlertDialog.apiServerErrorAlertDialog('خطا في الاتصال بالانترنت ', '');
      // }
    }).onError((error, stackTrace) {
      print('Error :' + error.toString());
      print('stackTrace :' + stackTrace.toString());
      CtmAlertDialog.apiServerErrorAlertDialog('غير متصل', error.toString());
    });
  }
}
