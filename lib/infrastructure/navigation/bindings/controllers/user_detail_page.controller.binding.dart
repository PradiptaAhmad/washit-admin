import 'package:get/get.dart';
import 'package:washit_admin/presentation/user_detail_page/controllers/user_detail_page.controller.dart';

class UserDetailPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserDetailPageController>(
      () => UserDetailPageController(),
    );
  }
}
