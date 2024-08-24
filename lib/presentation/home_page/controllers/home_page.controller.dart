import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:washit_admin/config.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/presentation/home_page/models/OrdersModel.dart';

class HomePageController extends GetxController {
  final count = 0.obs;

  // GetStorage
  final box = GetStorage();

  // Init Data
  var userData = {}.obs;
  var isLoading = false.obs;
  final url = ConfigEnvironments.getEnvironments()["url"];

  var dailyOrders = <OrdersModel>[].obs;
  var dailyChartData = <FlSpot>[].obs;

  var weeklyOrders = <OrdersModel>[].obs;
  var weeklyChartData = <FlSpot>[].obs;

  var monthlyOrders = <OrdersModel>[].obs;
  var monthlyChartData = <FlSpot>[].obs;

  Future<void> fetchUserData() async {
    final token = box.read("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
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
    final token = box.read("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse("$url/charts/orders/daily"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final dataList = data['data'] as List;

        // Simpan data ke dalam weeklyOrders sebagai OrdersModel
        List<OrdersModel> fetchedOrders = dataList
            .map((json) => OrdersModel.fromJson(json))
            .toList();

        // Jika jumlah data lebih dari 7, perbarui data di monthlyOrders
        if (fetchedOrders.length > 7) {
          // Mengganti data lama dengan data baru secara bergiliran berdasarkan id
          int startIndex = dailyOrders.length;
          for (int i = 0; i < fetchedOrders.length; i++) {
            if (i < 7) {
              if (i < dailyOrders.length) {
                dailyOrders[i] = fetchedOrders[i];
              } else {
                dailyOrders.add(fetchedOrders[i]);
              }
            } else {
              int replaceIndex = i % 7; // Menghitung indeks untuk menggantikan data
              dailyOrders[replaceIndex] = fetchedOrders[i];
            }
          }
        } else {
          // Jika data kurang dari atau sama dengan 7, tambahkan data ke monthlyOrders
          dailyOrders.value = fetchedOrders;
        }

        // Konversi OrdersModel ke FlSpot dan simpan di weeklyChartData
        dailyChartData.value = List.generate(
          dailyOrders.length,
              (index) {
            double totalOrders = double.parse(dailyOrders[index].totalOrder ?? '0');
            return FlSpot(index.toDouble() * 10, totalOrders);
          },
        );
      } else {
        Get.snackbar("Gagal Mengambil Data", "Silahkan coba lagi",
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Silahkan coba lagi",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchWeeklyChartData() async {
    final token = box.read("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse("$url/charts/orders/weekly"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final dataList = data['data'] as List;

        // Simpan data ke dalam weeklyOrders sebagai OrdersModel
        List<OrdersModel> fetchedOrders = dataList
            .map((json) => OrdersModel.fromJson(json))
            .toList();

        // Jika jumlah data lebih dari 7, perbarui data di monthlyOrders
        if (fetchedOrders.length > 7) {
          // Mengganti data lama dengan data baru secara bergiliran berdasarkan id
          int startIndex = weeklyOrders.length;
          for (int i = 0; i < fetchedOrders.length; i++) {
            if (i < 7) {
              if (i < weeklyOrders.length) {
                weeklyOrders[i] = fetchedOrders[i];
              } else {
                weeklyOrders.add(fetchedOrders[i]);
              }
            } else {
              int replaceIndex = i % 7; // Menghitung indeks untuk menggantikan data
              weeklyOrders[replaceIndex] = fetchedOrders[i];
            }
          }
        } else {
          // Jika data kurang dari atau sama dengan 7, tambahkan data ke monthlyOrders
          weeklyOrders.value = fetchedOrders;
        }

        // Konversi OrdersModel ke FlSpot dan simpan di weeklyChartData
        weeklyChartData.value = List.generate(
          weeklyOrders.length,
              (index) {
            double totalOrders = double.parse(weeklyOrders[index].totalOrder ?? '0');
            return FlSpot(index.toDouble() * 10, totalOrders);
          },
        );
      } else {
        Get.snackbar("Gagal Mengambil Data", "Silahkan coba lagi",
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Silahkan coba lagi",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    } finally {
      isLoading(false);
    }
  }


  Future<void> fetchMonthlyChartData() async {
    final token = box.read("token");
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse("$url/charts/orders/monthly"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final dataList = data['data'] as List;

        // Simpan data ke dalam monthlyOrders sebagai OrdersModel
        List<OrdersModel> fetchedOrders = dataList
            .map((json) => OrdersModel.fromJson(json))
            .toList();

        // Jika jumlah data lebih dari 7, perbarui data di monthlyOrders
        if (fetchedOrders.length > 7) {
          // Mengganti data lama dengan data baru secara bergiliran berdasarkan id
          int startIndex = monthlyOrders.length;
          for (int i = 0; i < fetchedOrders.length; i++) {
            if (i < 7) {
              if (i < monthlyOrders.length) {
                monthlyOrders[i] = fetchedOrders[i];
              } else {
                monthlyOrders.add(fetchedOrders[i]);
              }
            } else {
              int replaceIndex = i % 7; // Menghitung indeks untuk menggantikan data
              monthlyOrders[replaceIndex] = fetchedOrders[i];
            }
          }
        } else {
          // Jika data kurang dari atau sama dengan 7, tambahkan data ke monthlyOrders
          monthlyOrders.value = fetchedOrders;
        }

        // Konversi OrdersModel ke FlSpot dan simpan di monthlyChartData
        monthlyChartData.value = List.generate(
          monthlyOrders.length,
              (index) {
            double totalOrders = double.parse(monthlyOrders[index].totalOrder ?? '0');
            return FlSpot(index.toDouble() * 10, totalOrders);
          },
        );
      } else {
        Get.snackbar("Gagal Mengambil Data", "Silahkan coba lagi",
            snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar("Terjadi Kesalahan", "Silahkan coba lagi",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    } finally {
      isLoading(false);
    }
  }


  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchWeeklyChartData();
    fetchMonthlyChartData();
  }

  void increment() => count.value++;
}
