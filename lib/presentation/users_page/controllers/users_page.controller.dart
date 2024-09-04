import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/config.dart';

class UsersPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  late TabController tabController;

  // Init Data
  final box = GetStorage();
  final url = ConfigEnvironments.getEnvironments()["url"];
  var userData = [].obs;
  var isLoading = false.obs;

  var reviews = [].obs;
  var averageRating = 0.0.obs;
  var totalReviews = 0.obs;

  var selectedRating = 0.obs;

  // List<Review> get filteredReviews {
  //   if (selectedRating.value == 0) {
  //     return reviews;
  //   } else {
  //     return reviews
  //         .where((review) => review.rating == selectedRating.value)
  //         .toList();
  //   }
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

  Future<void> fetchRatingReviews() async {
    final token = box.read("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(
      Uri.parse("$url/admin/ratings/all"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      reviews.assignAll(json.decode(response.body)['rating']);
      // var reviewList = json.decode(response.body)['rating'] as List;
      // reviews.assignAll(
      //   reviewList.map((review) => Review(
      //     id: review['id'],
      //     rating: review['rating'],
      //     comment: review['review'],
      //     username: review['user']['username'],
      //   )).toList(),
      // );
      print(response.body);
    } else {
      print(response.body);
      Get.snackbar("Gagal Mengambil Data", "Silahkan coba lagi",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    }
  }

  Future<void> fetchRatingSummary() async {
    final token = box.read("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(
      Uri.parse("$url/admin/ratings/summary"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      averageRating.value = data['average_rating'].toDouble();
      totalReviews.value = data['total_review'];
      print(response.body);
    } else {
      print(response.body);
      Get.snackbar("Gagal Mengambil Data", "Silahkan coba lagi",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    }
  }

  Future<void> deleteRating(int id) async {
    final token = box.read("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.delete(
      Uri.parse("$url/admin/ratings/delete?id=$id"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      reviews.removeWhere((review) => review.id == id);
      fetchRatingReviews();
      Get.snackbar(
        "Sukses",
        "Rating berhasil dihapus",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
      );
    } else {
      print(response.body);
      Get.snackbar(
        "Gagal Menghapus Data",
        "Silahkan coba lagi",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
      );
    }
  }

  void onRefresh() async {
    isLoading.value = true;
    await fetchUserData();
    await fetchRatingReviews();
    await fetchRatingSummary();
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    onRefresh();
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
