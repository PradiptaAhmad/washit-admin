import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/config.dart';
import 'package:washit_admin/presentation/home_page/models/chart_model.dart';

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final count = 0.obs;
  var isLoading = false.obs;
  late TabController tabController;

  // Init Data
  var userData = {}.obs;
  var dailyData = {}.obs;
  var weeklyChartDatas = <ChartModel>[].obs;
  var sumTotalOrders = 0.obs;
  final box = GetStorage();

  Future<void> fetchUserData() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
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
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Silahkan coba lagi",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    }
  }

  Future<void> fetchDailyChartData() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read("token");

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var response = await http.get(
        Uri.parse("$url/charts/orders/daily"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        dailyData.value = jsonResponse;
      } else {
        Get.snackbar("Gagal Mengambil Data", "Silahkan coba lagi",
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      }
    } catch (e) {
      print(e);
      Get.snackbar("Terjadi Kesalahan", "Silahkan coba lagi",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    }
  }

  Future<void> getWeeklyChartData() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read("token");
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

      var response = await http.get(
        Uri.parse("$url/charts/orders/weekly"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['total_orders'];
        List<dynamic> data = json.decode(response.body)['data'];
        sumTotalOrders.value = jsonResponse;
        weeklyChartDatas.value =
            data.map((json) => ChartModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load chart data${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> onRefresh() async {
    isLoading.value = true;
    await fetchUserData();
    await fetchDailyChartData();
    await getWeeklyChartData();
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    onRefresh();
    tabController = TabController(length: 3, vsync: this);
  }

  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  void increment() => count.value++;
}
