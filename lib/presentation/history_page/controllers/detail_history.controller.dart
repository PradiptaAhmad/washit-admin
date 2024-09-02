import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';

class DetailHistoryController extends GetxController {
  var isLoading = false.obs;
  var detailData = {}.obs;
  GetStorage box = GetStorage();
  late final int orderId;
  var statusList = {}.obs;

  late final argument;

  Future<void> getDetailHistory() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token')?.toString();

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/admin/histories/detail?history_id=$orderId'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body)['data'];
        detailData.value = jsonResponse;
        print(detailData.length);
        print('Detail Data: $detailData');
      } else {
        Get.snackbar('Error', '${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchStatusData() async {
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


  Future<void> onRefresh({required String orderId}) async {
    isLoading.value = true;
    await getDetailHistory();
    await fetchStatusData();
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    orderId = Get.arguments['orderId'];
    getDetailHistory();
    fetchStatusData();
  }
}
