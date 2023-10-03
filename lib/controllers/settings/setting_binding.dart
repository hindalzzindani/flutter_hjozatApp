
import 'package:flutter_hjozatapp/controllers/settings/setting_controller.dart';
import 'package:get/get.dart';

class SettingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SettingController>(SettingController(), permanent: true);
  }
}
