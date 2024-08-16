import 'package:get/get.dart';
import 'package:washit_admin/presentation/fiturService_page/controllers/fiturService_controller.dart';

class FiturPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FiturController>(
          () => FiturController(),
    );
  }
}
