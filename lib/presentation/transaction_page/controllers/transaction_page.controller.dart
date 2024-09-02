import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../config.dart';

class TransactionPageController extends GetxController {
  final count = 0.obs;
  var isLoading = false.obs;
  var detailData = {}.obs;
  var statusList = {}.obs;
  GetStorage box = GetStorage();

  late final argument;

  Future<void> fetchDetailsOrder() async {
    isLoading.value = true;
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/admin/orders/detail?order_id=${argument}'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['order'];
        detailData.value = jsonResponse;
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
        Uri.parse('$url/admin/orders/status/last?order_id=${argument}'),
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

  Future<void> updateStatus() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.put(
        Uri.parse('$url/admin/orders/status/update?order_id=${argument}'),
        headers: headers,
      );

      if (response.statusCode == 201) {
        update();
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

  Future<void> updateLaundryWeight(double weight) async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      final response = await http.put(
        Uri.parse('$url/admin/orders/update-weight?order_id=${argument}'),
        headers: headers,
        body: jsonEncode({'id': argument['id'], 'berat_laundry': weight}),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'Weight updated successfully');
        await fetchDetailsOrder();
      } else {
        final responseBody = jsonDecode(response.body);
        Get.snackbar('Error',
            'Status Code: ${response.statusCode}, Message: ${responseBody['message']}');
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${responseBody}');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      print(e);
    }
  }

  @override
  void onInit() async {
    super.onInit();
    argument = Get.arguments;
    isLoading.value = true;
    await fetchDetailsOrder();
    await fetchStatusData();
    isLoading.value = false;
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
