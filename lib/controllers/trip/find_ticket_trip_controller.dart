import 'dart:convert';

import '../../common/ctm_alert_widget.dart';
import '../../models/find_tickets_trip_list_model.dart';
import '../../repository/booking_repository.dart';
import 'package:get/get.dart';

class FindTicketTripController extends GetConnect {
  ///find Tickets  init 01
  RxList<FindTicketListModel> findTicketsList =
      List<FindTicketListModel>.empty(growable: true).obs;
  RxList<FindTicketListModel> findTicketsListToday =
      List<FindTicketListModel>.empty(growable: true).obs;
  RxBool isDataLoading = false.obs;
  RxBool isDataLoadingToday = false.obs;
  RxBool isDataEmptyToday = false.obs;
  RxString msgToday = 'لايوحد بيانات!'.obs;
  RxBool isDataEmpty = false.obs;
  RxString msg = 'لايوجد بيانات'.obs;

  findTicketsTripCTR(Map<String, dynamic> findTicketMapBody) {
    BookingRepository()
        .bookingFindTicketsTripRep(findTicketMapBody)
        .then((resValue) async {
      findTicketsList.clear();
      isDataLoading.value = false;
      print("response:${resValue.body}");
      var bodyMap = json.decode(resValue.body);

      print('trip code  : ' + bodyMap['status'].toString());
      // print('trip code body   : ' + bodyMap.toString());
      print('trip res  : ' + bodyMap['response'].toString());

      if (bodyMap['status'] == "success") {
        if (bodyMap['response'] == 200) {
          if (bodyMap['data'] != null) {
            print(bodyMap['data']);
            for (var fTList in bodyMap['data']) {
              findTicketsList.add(FindTicketListModel.fromJson(fTList));
            }
            isDataLoading.value = true;
          }
        }
      } else {
        isDataEmpty.value = true;
        Get.back();
        msgToday.value = bodyMap['message'];
        CtmAlertDialog.apiServerErrorAlertDialog('تنبيه', msg.toString());
      }
    }).onError((error, stackTrace) {
      CtmAlertDialog.apiServerErrorAlertDialog('غير متصل', 'تنبيه');
      Get.back();
    });
  }

  findTicketsTripOnlyDateCTR(Map<String, dynamic> findTicketMapBody) {
    BookingRepository()
        .bookingFindTicketsTripOnlyDateRep(findTicketMapBody)
        .then((resValue) async {
      findTicketsList.clear();
      isDataLoading.value = false;
      print("response:${resValue.body}");
      var bodyMap = json.decode(resValue.body);

      print('trip code  : ' + bodyMap['status'].toString());
      // print('trip code body   : ' + bodyMap.toString());
      print('trip res  : ' + bodyMap['response'].toString());

      if (bodyMap['status'] == "success") {
        if (bodyMap['response'] == 200) {
          if (bodyMap['data'] != null) {
            print(bodyMap['data']);
            for (var fTList in bodyMap['data']) {
              findTicketsList.add(FindTicketListModel.fromJson(fTList));
            }
            isDataLoading.value = true;
          }
        }
      } else {
        isDataEmpty.value = true;
        Get.back();
        msgToday.value = bodyMap['message'];
        CtmAlertDialog.apiServerErrorAlertDialog('تنبيه', msg.toString());
      }
    }).onError((error, stackTrace) {
      CtmAlertDialog.apiServerErrorAlertDialog('غير متصل', 'تنبيه');
      Get.back();
    });
  }

  findTicketsTripCTRTODAY() {
    BookingRepository().bookingFindTicketsTripRepTODAY().then((resValue) async {
      isDataLoadingToday.value = false;
      findTicketsListToday.clear();
      var bodyMap = json.decode(resValue.body);

      print('trip code  : ' + bodyMap['status'].toString());
      // print('trip code body   : ' + bodyMap.toString());
      print('trip res  : ' + bodyMap['response'].toString());

      if (bodyMap['status'] == "success") {
        if (bodyMap['response'] == 200) {
          if (bodyMap['data'] != null) {
            print(bodyMap['data']);
            for (var fTList in bodyMap['data']) {
              findTicketsListToday.add(FindTicketListModel.fromJson(fTList));
            }
            isDataLoadingToday.value = true;
            isDataLoadingToday.refresh();
            print("its here:${isDataLoadingToday.value}");
          }
        }
      } else {
        isDataLoadingToday.value = true;
        isDataEmptyToday.value = true;
        Get.back();
        msg.value = bodyMap['message'];
        CtmAlertDialog.apiServerErrorAlertDialog('تنبيه', msg.toString());
      }
    }).onError((error, stackTrace) {
      CtmAlertDialog.apiServerErrorAlertDialog('غير متصل', 'تنبيه');
      Get.back();
    });
  }
}
