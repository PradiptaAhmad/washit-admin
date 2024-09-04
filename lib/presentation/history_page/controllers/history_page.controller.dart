import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../config.dart';

class HistoryPageController extends GetxController {
  final count = 0.obs;
  final isSelected = 0.obs;
  var isLoading = false.obs;
  final orderList = [].obs;
  var ordersList = [].obs;
  var filteredOrdersList = [].obs;
  var orderid = ''.obs;
  var statusList = {}.obs;
  var pagination = 1.obs;
  var isMaxPage = false.obs;
  var isLoadingMore = false.obs;
  GetStorage box = GetStorage();
  final scrollController = ScrollController();

  Future<void> getOrderHistory() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token')?.toString();

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/admin/histories/all?page=${pagination.value}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        if (List.from(jsonResponse).isEmpty) {
          isMaxPage.value = true;
        }
        ordersList.addAll(jsonResponse);
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.statusCode);
      }
    } catch (e) {
      Get.snackbar('Error Catch', e.toString());
      print(e);
    }
  }

  Future<void> fetchHistoryByStatus(String status) async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      final response = await http.get(
        Uri.parse(
            "${url}/admin/histories/filter/status?status=${status}&page=${pagination.value}"),
        headers: headers,
      );

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body)['data'];
        if (data.isEmpty) {
          isMaxPage.value = true;
        }
        filteredOrdersList.addAll(jsonDecode(response.body)['data']);
      } else {
        Get.snackbar('Error', '${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error catch', e.toString());
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilter() {
    switch (isSelected.value) {
      case 0:
        onRefresh();
        break;
      case 1:
        if (isLoadingMore.value == false) {
          isLoading.value = true;
          isMaxPage.value = false;
          pagination.value = 1;
          filteredOrdersList.clear();
        }
        fetchHistoryByStatus('completed');
        break;
      case 2:
        if (isLoadingMore.value == false) {
          isLoading.value = true;
          isMaxPage.value = false;
          pagination.value = 1;
          filteredOrdersList.clear();
        }
        fetchHistoryByStatus('canceled');
        break;
    }
  }

  Future<void> onRefresh() async {
    isMaxPage.value = false;
    pagination.value = 1;
    filteredOrdersList.clear();
    ordersList.clear();
    isLoading.value = true;
    await getOrderHistory();
    isLoading.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
    onRefresh();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (!isMaxPage.value) {
          isLoadingMore.value = true;
          pagination.value++;
          print(isMaxPage.value);
          print(pagination.value);
          if (isSelected.value == 0) {
            getOrderHistory();
          } else {
            applyFilter();
          }
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
