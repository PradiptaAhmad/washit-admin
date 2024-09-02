import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../../config.dart';

class HistoryPageController extends GetxController {
  final count = 0.obs;
  final isSelected = 0.obs;
  var isLoading = false.obs;
  final orderList = [].obs;
  final laundries = [].obs;
  var ordersList = [].obs;
  var filteredOrdersList = [].obs;
  var orderid = ''.obs;
  var statusList = {}.obs;
  GetStorage box = GetStorage();


  Future<void> getOrderHistory() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token')?.toString();

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      final response = await http.get(
        Uri.parse('$url/admin/histories/all'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        ordersList.value = jsonResponse;
        print(ordersList.length);
      } else {
        Get.snackbar('Error', '${response.statusCode}');
        print(response.statusCode);
      }
    } catch (e) {
      Get.snackbar('Error Catch', e.toString());
      print(e);
    }
  }

  void applyFilter() {
    switch (isSelected.value) {
      case 0:
        filteredOrdersList.value = ordersList;
        break;
      case 1:
        filteredOrdersList.value = ordersList
            .where((element) => element['status'] == 'completed')
            .toList();
        break;
      case 2:
        filteredOrdersList.value = ordersList
            .where((element) => element['status'] == 'canceled')
            .toList();
        break;
    }
  }

  Future<void> onRefresh() async {
    isLoading.value = true;
    await getOrderHistory();
    isLoading.value = false;
  }

  @override
  void onInit() async {
    super.onInit();
    await getOrderHistory();
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
