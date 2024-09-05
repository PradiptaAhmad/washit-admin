import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/widget/common/custom_pop_up.dart';

import '../../../config.dart';

class HistoryTransactionPageController extends GetxController {
  // Important
  final count = 0.obs;
  var isLoading = false.obs;
  GetStorage box = GetStorage();

  // Var
  var sumTransaction = 0.obs;
  var sumTransactionCount = 0.obs;
  var transactionList = [].obs;

  Future<void> getFetchTransactionData() async {
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
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mengambil data Transaksi', warningColor);
    }
  }

  void onRefresh() async {
    isLoading.value = true;
    await getFetchTransactionData();
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    onRefresh();
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
