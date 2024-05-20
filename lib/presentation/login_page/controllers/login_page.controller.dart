import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';

class LoginPageController extends GetxController {
  // Password Visibility
  var isObsecure = false.obs;

  // Email and Password
  var email = ''.obs;
  var password = ''.obs;

  // Other
  GetStorage box = GetStorage();

  Future<void> login() async {
    final url = ConfigEnvironments.getEnvironments()["url"];
    var data = {
      'email': email.value,
      'password': password.value,
    };
    var headers = {
      'Accept': 'application/json',
    };

    var response = await http.post(
      Uri.parse("$url/admin/accounts/login"),
      headers: headers,
      body: data,
    );

    if (response.statusCode == 200) {
      final token = json.decode(response.body)['token'];
      final admin = json.decode(response.body)['admin'];
      box.write("token", token);
      Get.snackbar("Sukses Login", "Selamat datang ${admin['name']}",
          snackPosition: SnackPosition.TOP, backgroundColor: successColor);
    } else {
      Get.snackbar("Gagal Login", json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
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
}
