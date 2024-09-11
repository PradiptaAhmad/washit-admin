import 'package:get/get.dart';
import 'package:washit_admin/presentation/chat_page/controllers/chat_page.controller.dart';

class ChatPageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChatPageController>(
      () => ChatPageController(),
    );
  }
}
