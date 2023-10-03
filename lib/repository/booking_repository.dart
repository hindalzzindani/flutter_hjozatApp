import 'dart:convert';

import 'package:flutter_hjozatapp/local_db_sqflite/db_helper_local.dart';

import '../../common/api_url.dart';
import '../../common/restapi_status.dart';
import 'package:http/http.dart' as http;

class BookingRepository {

  /// pay now
  Future creteTicketBookingRep(Map<String, dynamic> creteTBMap) async {

    Uri url = Uri.parse(ApiURL.ticketBookingPostUrl);
    try {
      final response = await http.post(url,
          body: jsonEncode(creteTBMap), headers: RestApiStatus().headerMapWithToken);
      print('url:$url :bodyResponseCTB code :' + response.body.toString());
      return response;
    } on Exception catch (exception) {
      throw (exception);
    } catch (error) {
      throw Exception(error);
    }
  }

  /// Pay later
  Future creteTicketBookingUnpaidRep(Map<String, dynamic> creTBUMap) async {

    Uri url = Uri.parse(ApiURL.ticketBookingUnpaidPostUrl);
    try {
      final response = await http.post(url,
          body: json.encode(creTBUMap), headers: RestApiStatus().headerMapWithToken);
      print('url:${url}:bodyResponseCTBU code:' + response.statusCode.toString()+":${response.body.toString()}");
      return response;
    } on Exception catch (exception) {
      print("error here:${exception}");
      throw (exception);
    } catch (error) {
      print("error here1:${error}");
      throw Exception(error);


    }
  }

  Future bookingFindTicketsTripRep(Map<String, dynamic> forgetMap) async {

    Uri url = Uri.parse(ApiURL.bookingFindTicketsTripListPostUrl);
    try {
      final response = await http.post(url, body: forgetMap);
      print('$url : ${forgetMap}:bodyResponseBFTTR code :' + response.statusCode.toString()+":${response.body}");
      return response;

    } on Exception catch (exception) {
      throw (exception);
    } catch (error) {
      throw Exception(error);
    }
  }
  Future bookingFindTicketsTripOnlyDateRep(Map<String, dynamic> forgetMap) async {

    Uri url = Uri.parse(ApiURL.bookingFindTicketsTripListOnlyDatePostUrl);
    try {
      final response = await http.post(url, body: forgetMap);
      print('$url : ${forgetMap}:bodyResponseBFTTR code :' + response.statusCode.toString()+":${response.body}");
      return response;

    } on Exception catch (exception) {
      throw (exception);
    } catch (error) {
      throw Exception(error);
    }
  }
  Future bookingFindTicketsTripRepTODAY() async {

    Uri url = Uri.parse(ApiURL.bookingFindTicketsTripListPostUrlToday);
    try {
      final response = await http.get(url, );
      print('url:$url :bodyResponseBFTTR code :' + response.statusCode.toString()+":${response.body.toString()}");
      return response;

    } on Exception catch (exception) {
      throw (exception);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future bookingTicketHistoryRep() async {
    print("token:${DBHelper01.getToken('token').toString()}");
    Uri url = Uri.parse(ApiURL.bookingTicketsHistoryGetUrl);
    print("url:${url}");
    try {
      final response = await http.get(url,headers: RestApiStatus().headerMapWithToken);
      print('رمزتاريخ تذكرة الحجز  :' + response.statusCode.toString());
      print('رمزتاريخ تذكرة الحجز  :' + response.body.toString());
      return response;
    } on Exception catch (exception) {
      throw (exception);
    } catch (error) {
      throw Exception(error);
    }
  }

}
