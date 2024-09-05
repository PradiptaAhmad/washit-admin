import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/widget/common/custom_pop_up.dart';

import '../../../config.dart';

class TransactionPageController extends GetxController {
  //Important
  final count = 0.obs;
  var isLoading = true.obs;
  GetStorage box = GetStorage();

  //Var
  var detailData = {}.obs;
  var statusList = {}.obs;
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
        Uri.parse(argument[1] == 'status'
            ? '$url/admin/orders/detail?order_id=${argument[0]}'
            : '$url/admin/histories/detail?history_id=${argument[0]}'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final jsonResponse = argument[1] == 'status'
            ? jsonDecode(response.body)['order']
            : jsonDecode(response.body)['data'];
        detailData.value = jsonResponse;
        if (argument[1] == 'history') {
          if (jsonResponse['status'] == 'completed') {
            statusList.value = {
              'status_code': 5,
              'status_description': 'Pesanan Selesai',
            };
          } else {
            statusList.value = {
              'status_code': 1,
              'status_description': 'Pesanan Dibatalkan',
            };
          }
        }
      } else {
        customPopUp("Error, Kode:${response.statusCode}", warningColor);
      }
    } catch (e) {
      customPopUp("Error, gagal untuk memanggil order data", warningColor);
    }
  }

  Future<void> fetchStatusData() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      final response = await http.get(
        Uri.parse('$url/admin/orders/status/last?order_id=${argument[0]}'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['order_status'];
        statusList.value = jsonResponse;
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp("Error, gagal untuk memanggil data status", warningColor);
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
        Uri.parse('$url/admin/orders/status/update?order_id=${argument[0]}'),
        headers: headers,
      );
      if (response.statusCode == 201) {
        update();
        onRefresh();
      } else {
        customPopUp("Error, Kode:${response.statusCode}", warningColor);
      }
    } catch (e) {
      customPopUp("Error, gagal untuk memperbarui status", warningColor);
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
        Uri.parse('$url/admin/orders/update-weight?order_id=${argument[0]}'),
        headers: headers,
        body: jsonEncode({'id': argument[0], 'berat_laundry': weight}),
      );
      if (response.statusCode == 201) {
        customPopUp(
            "Sukses, Berat laundry telah berhasil di perbarui, ", successColor);
        onRefresh();
      } else {
        customPopUp("Error, Kode:${response.statusCode}", warningColor);
      }
    } catch (e) {
      customPopUp("Error, gagal untuk memperbarui berat laundry", warningColor);
    }
  }

  void onRefresh() async {
    isLoading.value = true;
    await fetchDetailsOrder();
    if (argument[1] == 'status') {
      await fetchStatusData();
    }
    isLoading.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
    argument = Get.arguments;
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
