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
  late TabController tabController;
  var ordersList = [].obs;
  GetStorage box = GetStorage();

  Future<void> fetchOrders() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token')?.toString();

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/admin/orders/all'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['orders'];
        ordersList.value = jsonResponse;
        print(ordersList.length);
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 5, vsync: this);
    await fetchOrders();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  void increment() => count.value++;
}
