import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/infrastructure/navigation/routes.dart';

import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';

class LoginPageController extends GetxController {
  // Password Visibility
  var isObsecure = true.obs;

  // Email and Password
  var email = ''.obs;
  var password = ''.obs;

  // Loading
  var isLoading = false.obs;

  // Other
  GetStorage box = GetStorage();

  Future<void> login() async {
    isLoading.toggle();
    final url = ConfigEnvironments.getEnvironments()["url"];
    final notificationToken = await FirebaseMessaging.instance.getToken();
    var data = {
      'email': email.value,
      'password': password.value,
      'notification_token': notificationToken,
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
      final admin = json.decode(response.body)['user'];
      box.write("token", token);
      Get.snackbar("Sukses Login", "Selamat datang ${admin['username']}",
          snackPosition: SnackPosition.TOP, backgroundColor: successColor);
      Get.offAllNamed(Routes.NAVBAR);
    } else {
      Get.snackbar("Gagal Login", json.decode(response.body)['message'],
          snackPosition: SnackPosition.TOP, backgroundColor: warningColor);
    }
    isLoading.toggle();
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
