import 'package:get/get.dart';
import 'package:washit_admin/presentation/review_page/controllers/review_page.controller.dart';


class ReviewPagecontrollerbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReviewPageController>(
          () => ReviewPageController(),
    );
  }
}