import 'package:get/get.dart';
import 'package:washit_admin/presentation/chat_detail_page/controllers/chat_detail_page.controller.dart';

class ChatDetailPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatDetailPageController>(
      () => ChatDetailPageController(),
    );
  }
}
