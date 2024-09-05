import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/widget/common/custom_pop_up.dart';

import '../../../config.dart';

class AddNotificationPageController extends GetxController {
  // Important
  final count = 0.obs;
  var isLoading = false.obs;
  GetStorage box = GetStorage();

  // Var
  var judul = ''.obs;
  var deskripsi = ''.obs;

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
        customPopUp(
            'Sukses, berhasil untuk menyiarkan notifikasi', successColor);
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk menyiarkan notifikasi', warningColor);
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
