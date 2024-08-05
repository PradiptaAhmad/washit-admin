import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:washit_admin/config.dart';
import 'package:http/http.dart' as http;  


class UsersPageController extends GetxController with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  late TabController tabController;

  // Init Data
  final box = GetStorage();
  final url = ConfigEnvironments.getEnvironments()["url"];
  var userData = [].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    isLoading.value = true;
    fetchUserData();
    isLoading.value = false;
    super.onInit();
    // fetchUsers();
  }

  // void fetchUsers() async {
  //   users.value = [
  //     User(name: 'Marlen', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '081-872-9011'),
  //     User(name: 'Adib', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '083-562-7721'),
  //     User(name: 'Abid', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '085-377-8767'),
  //     User(name: 'Vania', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '089-122-7121'),
  //     User(name: 'Daffa', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '086-882-1121'),
  //     User(name: 'Dika', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '084-991-7112'),
  //     User(name: 'Vino', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '082-770-4411'),
  //     User(name: 'Roro', imagePath: 'assets/img_user/avatar1.jpg', phoneNumber: '087-619-0192'),
  //   ];
  // }

  Future<void> fetchUserData() async {
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
      userData.assignAll(json.decode(response.body)['user']);
      print(response.body);
    } else {
      print(response.body);
      Get.snackbar("Gagal Mengambil Data", "Silahkan coba lagi",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();

  }

  void increment() => count.value++;
}

class User {
  final String name;
  final String imagePath;
  final String phoneNumber;

  User({required this.name, required this.imagePath, required this.phoneNumber});
}
