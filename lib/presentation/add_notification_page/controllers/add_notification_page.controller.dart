import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';

class AddNotificationPageController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var judul = ''.obs;
  var deskripsi = ''.obs;
  GetStorage box = GetStorage();

  Future<void> postNotification() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      var data = {
        'title': judul.toString(),
        'body': deskripsi.toString(),
      };
      final response = await http.post(
        Uri.parse("${url}/notifications/send-to-all"),
        headers: headers,
        body: data,
      );
      if (response.statusCode == 200) {
      } else {
        Get.snackbar('Error', '${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error catch', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
