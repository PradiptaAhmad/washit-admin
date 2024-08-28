import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/config.dart';

import '../models/ReviewModel.dart';

class UsersPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  late TabController tabController;

  // Init Data
  final box = GetStorage();
  final url = ConfigEnvironments.getEnvironments()["url"];
  var userData = [].obs;
  var isLoading = false.obs;

  var selectedRating = 0.obs;
  var reviews = <Review>[
    Review(rating: 5, comment: "Excellent!", username: "User A"),
    Review(rating: 4, comment: "Very Good!", username: "User B"),
    Review(rating: 3, comment: "Good", username: "User C"),
    Review(rating: 2, comment: "Not bad", username: "User D"),
    Review(rating: 1, comment: "Needs improvement", username: "User E"),
  ].obs;

  List<Review> get filteredReviews {
    if (selectedRating.value == 0) {
      return reviews;
    } else {
      return reviews
          .where((review) => review.rating == selectedRating.value)
          .toList();
    }
  }

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
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    isLoading.value = true;
    fetchUserData();
    isLoading.value = false;
    super.onInit();
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

  User(
      {required this.name, required this.imagePath, required this.phoneNumber});
}
