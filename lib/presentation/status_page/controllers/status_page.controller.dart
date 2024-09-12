import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/widget/common/custom_pop_up.dart';

import '../../../config.dart';

class StatusPageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //Important
  final count = 0.obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var isMaxPage = false.obs;
  var scrollController = ScrollController();
  GetStorage box = GetStorage();

  //Var
  var filteredOrdersList = [].obs;
  var statusList = {}.obs;
  var ordersList = [].obs;
  var statusSelectedFilterName = ''.obs;
  var selectedFilter = 0.obs;
  var paginate = 1.obs;

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
        customPopUp('Error, Kode${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mengambil data Order', warningColor);
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
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mengambil data Status', warningColor);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFilteredOrder(String filter, String mode) async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');
      final response = await http.get(
        mode == "status"
            ? Uri.parse(
                '$url/admin/orders/filter/status?status_code=${filter}&page=${paginate.value}')
            : mode == "service"
                ? Uri.parse(
                    '$url/admin/orders/filter/service?service=${filter}&page=${paginate.value}')
                : Uri.parse('$url/orders/all?page${paginate.value}'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = jsonDecode(response.body)['data'];
        if (jsonResponse.isEmpty) {
          isMaxPage.value = true;
        }
        filteredOrdersList.addAll(jsonResponse);
        print(jsonResponse);
      } else {
        customPopUp("Error, Kode(${response.statusCode})", warningColor);
      }
    } catch (e) {
      customPopUp("Error, Kode(${e.toString()})", warningColor);
    }
  }

  void applyFilter(String mode) async {
    if (mode == 'paginate') {
      isLoadingMore.value = true;
      paginate.value++;
    } else {
      isLoading.value = true;
      paginate.value = 1;
      isMaxPage.value = false;
      filteredOrdersList.clear();
      ordersList.clear();
    }
    if (selectedFilter.value == 0) {
      await fetchOrders();
    } else if (selectedFilter.value == 1) {
      await fetchFilteredOrder("1", 'status');
    } else if (selectedFilter.value == 2) {
      await fetchFilteredOrder("2", 'status');
    } else if (selectedFilter.value == 3) {
      await fetchFilteredOrder("3", 'status');
    } else if (selectedFilter.value == 4) {
      await fetchFilteredOrder("4", 'status');
    } else if (selectedFilter.value == 5) {
      await fetchFilteredOrder("5", 'status');
    } else if (selectedFilter.value == 6) {
      await fetchFilteredOrder("antar_jemput", 'service');
    } else if (selectedFilter.value == 7) {
      await fetchFilteredOrder("antar_mandiri", 'service');
    }

    if (mode == 'paginate') {
      isLoadingMore.value = false;
    } else {
      isLoading.value = false;
    }
  }

  

  void onRefresh() async {
    isLoading.value = true;
    ordersList.clear();
    paginate.value = 1;
    isMaxPage.value = false;
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
