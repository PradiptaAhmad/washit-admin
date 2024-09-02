import 'package:get/get.dart';
import 'package:washit_admin/presentation/add_notification_page/controllers/add_notification_page.controller.dart';

class AddNotificationPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNotificationPageController>(
      () => AddNotificationPageController(),
    );
  }
}
