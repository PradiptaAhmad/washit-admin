import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';
import '../../../widget/common/custom_pop_up.dart';

class ChatPageController extends GetxController {
  //Important
  final count = 0.obs;
  var isLoading = false.obs;
  var userData = [].obs;

  final box = GetStorage();

  Future<void> fetchUserData() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read("token");
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await http.get(
        Uri.parse("$url/admin/users/all"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        userData.assignAll(jsonDecode(response.body)['user']);
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mengambil data User', warningColor);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchUserData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
