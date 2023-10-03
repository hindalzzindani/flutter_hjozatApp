import 'package:flutter_hjozatapp/local_db_sqflite/db_helper_local.dart';
import 'package:get_storage/get_storage.dart';

import '../../common/api_url.dart';
import '../../common/restapi_status.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {

  Future userProfileInfoRep() async {
    Uri url = Uri.parse(ApiURL.userProfileInfoGetUrl);
    try {
      print(GetStorage(DbStrings.dbName).read("token"));

      final response = await http.get(url,headers: RestApiStatus().headerMapWithToken);
      print('url:$url :${RestApiStatus().headerMapWithToken} :profile res code :' + response.statusCode.toString());
      return response;
    } on Exception catch (exception) {
      throw (exception);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future userProfileUpdateRep(Map<String, String> profileUpdateMap) async {
    Uri url = Uri.parse(ApiURL.userProfileUpdateUrl);
    try {
      final response = await http.post(url,
          body: profileUpdateMap, headers: RestApiStatus.headerMap);
      print('bodyResponseProfile code :' + response.statusCode.toString());
      return response;
    } on Exception catch (exception) {
      throw (exception);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future userChangePasswordRep(Map<String, String> changePassMap) async {
    Uri url = Uri.parse(ApiURL.userChangePassPostUrl);
    try {
      final response = await http.post(url,
          body: changePassMap, headers: RestApiStatus.headerMap);
      print('bodyResponseForget code :' + response.statusCode.toString());
      return response;
    } on Exception catch (exception) {
      throw (exception);
    } catch (error) {
      throw Exception(error);
    }
  }

}
