import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/infrastructure/navigation/routes.dart';
import 'package:washit_admin/widget/common/custom_pop_up.dart';

import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';

class LoginPageController extends GetxController {
  //Important
  var isObsecure = true.obs;
  var isLoading = false.obs;
  GetStorage box = GetStorage();

  //Var
  var email = ''.obs;
  var password = ''.obs;

  Future<void> login() async {
    isLoading.value = true;
    try {
      FocusScope.of(Get.overlayContext!).unfocus();
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
        customPopUp(
            'Sukses, selamat datang ${admin['username']}', successColor);
        Get.offAllNamed(Routes.NAVBAR);
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk masuk ke akun', warningColor);
      print(e);
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
}
