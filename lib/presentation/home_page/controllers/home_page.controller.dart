import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:washit_admin/config.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  //TODO: Implement HomePageController

  final count = 0.obs;

  // GetStorage
  final box = GetStorage();

  // Init Data
  var userData = {}.obs;
  var isLoading = false.obs;
  final url = ConfigEnvironments.getEnvironments()["url"];

  Future<void> fetchUserData() async {
    final token = box.read("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(
      Uri.parse("$url/admin/accounts/details"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      userData.value = json.decode(response.body)['admin'];
    } else {
      Get.snackbar("Gagal Mengambil Data", "Silahkan coba lagi",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    }
  }

  @override
  void onInit() {
    isLoading.value = true;
    // Implement fetch api here
    fetchUserData();
    isLoading.value = false;
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
