import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';

class StatusPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement StatusPageController

  final count = 0.obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var isMaxPage = false.obs;
  var jenisList = [].obs;
  var laundries = [].obs;
  var filteredOrdersList = [].obs;
  var statusList = {}.obs;
  var selectedFilter = 0.obs;
  var statusSelectedFilterName = ''.obs;
  var ordersList = [].obs;
  var paginate = 1.obs;
  var scrollController = ScrollController();
  GetStorage box = GetStorage();

  Future<void> fetchOrders() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token')?.toString();

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/admin/orders/all?page=${paginate.value}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['orders'];
        if (List.from(jsonResponse).isEmpty) {
          isMaxPage.value = true;
        }
        ordersList.addAll(jsonResponse);
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchStatusData(orderId) async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/admin/orders/status/last?order_id=${orderId}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['order_status'];
        statusList.value = jsonResponse;
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.statusCode);
      }
    } catch (e) {
      Get.snackbar('Error ', e.toString());
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilter() {
    final filters = [
      null,
      (order) => order['status'] == "Pesanan Telah Dibuat",
      (order) => order['status'] == "Pesanan telah dikonfirmasi",
      (order) => order['status'] == "Sedang diproses",
      (order) => order['status'] == "Menunggu Pembayaraan",
      (order) =>
          order['status'] == "Pesanan telah diantar" ||
          order['status'] == "Pesanan telah selesai",
      // (order) => order['jenis_pemesanan'] == "antar_jemput",
      // (order) => order['jenis_pemesanan'] == "antar_mandiri"
    ];

    filteredOrdersList.value = ordersList
        .where(filters[selectedFilter.value] ?? (order) => true)
        .toList();
  }

  void onRefresh() async {
    isLoading.value = true;
    await fetchOrders();
    isLoading.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
    onRefresh();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (isMaxPage.value == false) {
          paginate.value++;
          isLoadingMore.value = true;
          fetchOrders();
          isLoadingMore.value = false;
        }
      }
    });
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
