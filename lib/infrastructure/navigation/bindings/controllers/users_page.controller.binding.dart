import 'package:get/get.dart';

import '../../../../presentation/users_page/controllers/users_page.controller.dart';

class UsersPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsersPageController>(
      () => UsersPageController(),
    );
  }
}
