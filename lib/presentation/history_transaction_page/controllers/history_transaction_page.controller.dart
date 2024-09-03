import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';

class HistoryTransactionPageController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var transactionList = [].obs;
  var sumTransaction = 0.obs;
  var sumTransactionCount = 0.obs;
  GetStorage box = GetStorage();

  Future<void> getFetchTransactionData() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/admin/transaction/all'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        transactionList.value = jsonDecode(response.body)['transactions'];
        sumTransaction.value = jsonDecode(response.body)['total_amout'];
        sumTransactionCount.value =
            jsonDecode(response.body)['total_transaction'];
        print(response.body);
      } else {
        Get.snackbar("Error",
            "Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getFetchTransactionData();
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
