import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:washit_admin/presentation/fiturService_page/models/fiturService_model.dart';
import '../../../config.dart';

class FiturController extends GetxController {
  var fitur = <FiturModel>[].obs;
  var isLoading = false.obs;
  var isRefreshing = false.obs;

  GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    fetchFitur();
  }

  Future<void> fetchFitur() async {
    isLoading(true);
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse('$url/admin/laundry/details'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body) as List;
        fitur.value = data.map((e) => FiturModel.fromJson(e)).toList();
      } else {
        Get.snackbar("Error", "Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addFitur(String name, int estimasiWaktu, bool isActive) async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.post(
        Uri.parse('$url/admin/laundry/add'),
        headers: headers,
        body: json.encode({
          'name': name,
        }),
      );

      if (response.statusCode == 201) {
        fetchFitur();
        Get.snackbar("Success", "Fitur added successfully");
      } else {
        Get.snackbar("Error", "Failed to add fitur. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  Future<void> updateFitur(int id, String name, int estimasiWaktu, bool isActive) async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.put(
        Uri.parse('$url/admin/laundry/update/$id'),
        headers: headers,
        body: json.encode({
          'name': name,
        }),
      );

      if (response.statusCode == 200) {
        fetchFitur();
        Get.snackbar("Success", "Fitur updated successfully");
      } else {
        Get.snackbar("Error", "Failed to update fitur. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  Future<void> deleteFitur(int id) async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.delete(
        Uri.parse('$url/admin/laundry/delete/$id'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        fetchFitur();
        Get.snackbar("Success", "Fitur deleted successfully");
      } else {
        Get.snackbar("Error", "Failed to delete fitur. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  Future<void> refreshFitur() async {
    isRefreshing(true);
    await fetchFitur();
    isRefreshing(false);
  }
}