import 'package:get/get.dart';

import '../../../../presentation/settings_page/controllers/settings_page.controller.dart';

class SettingsPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsPageController>(
      () => SettingsPageController(),
    );
  }
}
