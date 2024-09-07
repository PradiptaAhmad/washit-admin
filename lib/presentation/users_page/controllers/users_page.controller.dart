import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/config.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/widget/common/custom_pop_up.dart';

class UsersPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //Important
  final count = 0.obs;
  var isLoading = false.obs;
  late TabController tabController;
  final box = GetStorage();

  //Var
  var userData = [].obs;
  var userDetailData = {}.obs;
  var filteredUserData = [].obs;
  var reviews = [].obs;
  var averageRating = 0.0.obs;
  var totalReviews = 0.obs;
  late final userId;

  Future<void> fetchUserData() async {
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
        userData.assignAll(json.decode(response.body)['user']);
        filteredUserData.assignAll(userData);
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mengambil data User', warningColor);
    }
  }

  Future<void> fetchRatingReviews() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
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
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mengambil data rating', warningColor);
    }
  }

  Future<void> fetchRatingSummary() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
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
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp(
          'Error, gagal untuk mengambil data rata-rata rating', warningColor);
    }
  }

  Future<void> deleteRating(int id) async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
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
        customPopUp('Sukses, berhasil untuk menambah Rating', successColor);
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk menghapus Rating', warningColor);
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
    userId = Get.arguments;
    onRefresh();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
