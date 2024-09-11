import 'package:get/get.dart';

class ChatDetailPageController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var messages = [].obs;

  void addMessage(String message) {
    if (message.isNotEmpty) {
      messages.add(message);
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
