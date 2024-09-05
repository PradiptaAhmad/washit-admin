import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/widget/common/custom_pop_up.dart';

import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';

class RegisterPageController extends GetxController {
  //Important
  var isObsecure = true.obs;
  var isLoading = false.obs;

  //Var
  var username = ''.obs;
  var email = ''.obs;
  var phone = ''.obs;
  var password = ''.obs;

  Future<void> register() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      var data = {
        'username': username.value,
        'email': email.value,
        'phone': phone.value,
        'password': password.value,
      };
      var headers = {
        'Accept': 'application/json',
      };
      final response = await http.post(
        Uri.parse("$url/users/register"),
        headers: headers,
        body: data,
      );
      if (response.statusCode == 200) {
        customPopUp('Sukses, berhasil untuk mendaftarkan akun', successColor);
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mendaftarkan akun', warningColor);
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
