import 'package:get/get.dart';

import '../../../../presentation/home_page/controllers/home_page.controller.dart';

class HomePageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomePageController>(
      () => HomePageController(),
    );
  }
}
