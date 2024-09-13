import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/config.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/home_page/models/order_chart_model.dart';
import 'package:washit_admin/widget/common/custom_pop_up.dart';

import '../models/transaction_weekly_chart_model.dart';

class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // Important
  final count = 0.obs;
  var isLoading = false.obs;
  late TabController tabController;
  final box = GetStorage();

  // Var
  var userData = {}.obs;
  var dailyOrderData = {}.obs;
  var dailyTransactionData = {}.obs;
  var weeklyOrderChartDatas = <orderChartModel>[].obs;
  var weeklyTransactionChartDatas = <TransactionWeeklyChartModel>[].obs;
  var ordersList = [].obs;
  var sumTotalOrders = 0.obs;
  var sumTotalEarnings = 0.obs;

  var overviewData = {}.obs;

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
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mengambil data Pengguna', warningColor);
    }
  }

  Future<void> fetchOrders() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await http.get(
        Uri.parse("$url/admin/orders/all"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body)['orders'] as List<dynamic>;
        var filteredOrders = data
            .where((order) => order['status'] == "Pesanan Telah Dibuat")
            .toList();
        ordersList.assignAll(filteredOrders);
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mengambil data Pesanan', warningColor);
    }
  }

  Future<void> fetchDailyTransactionData() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read("token");

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await http.get(
        Uri.parse("$url/charts/transactions/daily"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['data'] != null) {
          final jsonResponse = jsonDecode(response.body)['data'];
          dailyTransactionData.value = jsonResponse;
        }
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mengambil data Transaksi', warningColor);
    }
  }

  Future<void> fetchDailyOrderData() async {
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
        if (jsonDecode(response.body)['data'] != null) {
          final jsonResponse = jsonDecode(response.body)['data'];
          dailyOrderData.value = jsonResponse;
        }
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp(
          'Error, gagal untuk mengambil data Pesanan harian', warningColor);
    }
  }

  Future<void> getWeeklyOrderChartData() async {
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
        List<dynamic> data = jsonDecode(response.body)['data'];
        sumTotalOrders.value = jsonResponse;
        weeklyOrderChartDatas.value =
            data.map((json) => orderChartModel.fromJson(json)).toList();
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp(
          'Error, gagal untuk mengambil data Pesanan mingguan', warningColor);
    }
  }

  Future<void> getWeeklyTransactionChartData() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read("token");
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await http.get(
        Uri.parse("$url/charts/transactions/weekly"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['total_income'];
        List<dynamic> data = json.decode(response.body)['data'];
        print(data);
        sumTotalEarnings.value = jsonResponse;
        weeklyTransactionChartDatas.value = data
            .map((json) => TransactionWeeklyChartModel.fromJson(json))
            .toList();
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp(
          'Error, gagal untuk mengambil data Transaksi mingguan', warningColor);
    }
  }

  Future<void> fetchOverviewData() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read("token");
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var response = await http.get(
        Uri.parse("$url/admin/home/overview"),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        overviewData.value = jsonResponse;
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mengambil data Ringkasan', warningColor);
    }
  }

  Future<void> onRefresh() async {
    isLoading.value = true;
    await Future.wait([
      fetchOverviewData(),
      fetchOrders(),
      fetchUserData(),
      fetchDailyOrderData(),
      fetchDailyTransactionData(),
      getWeeklyOrderChartData(),
      getWeeklyTransactionChartData(),
    ]);
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    onRefresh();
  }

  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  void increment() => count.value++;
}
