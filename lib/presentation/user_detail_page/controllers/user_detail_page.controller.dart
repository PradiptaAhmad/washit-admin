import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/widget/common/custom_pop_up.dart';

import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';

class UserDetailPageController extends GetxController {
  //Important
  final count = 0.obs;
  var isLoading = false.obs;
  GetStorage box = GetStorage();

  //Var
  late final userId;
  var userDetailData = {}.obs;

  Future<void> fetchUserDetailData() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read("token");
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await http.get(
        Uri.parse("$url/admin/users/detail?id=${userId}"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        userDetailData.value = jsonDecode(response.body)['data'];
        print(userDetailData);
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
    userId = Get.arguments;
    await fetchUserDetailData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
