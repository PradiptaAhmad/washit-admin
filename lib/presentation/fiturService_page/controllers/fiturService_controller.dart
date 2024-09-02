import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../../config.dart';

class FiturController extends GetxController {
  var serviceList = [].obs;
  var isLoading = false.obs;
  var isRefreshing = false.obs;
  var namaLaundry = ''.obs;
  var harga = ''.obs;
  var estimasiWaktu = ''.obs;
  var deskripsi = ''.obs;
  var status = true.obs;

  GetStorage box = GetStorage();

  // TextEditingController
  var namaLaundryController = TextEditingController();
  var hargaController = TextEditingController();
  var estimasiWaktuController = TextEditingController();
  var deskripsiController = TextEditingController();
  

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
        Uri.parse('$url/admin/laundry/all'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body)['data'];
        serviceList.value = jsonResponse;
      } else {
        Get.snackbar("Error",
            "Failed to fetch data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> addFitur() async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${token.toString()}',
      };

      var data = {
        'nama_laundry': namaLaundry.toString(),
        'harga': harga.value,
        'estimasi_waktu': estimasiWaktu.toString(),
        'deskripsi': deskripsi.toString(),
        'is_active': status.value ? '1' : '0',
      };

      final response = await http.post(Uri.parse("${url}/admin/laundry/add"),
          headers: headers, body: data);

      if (response.statusCode == 201) {
        fetchFitur();
        Get.snackbar("Success", "Fitur added successfully");
      } else {
        print(data);
        print(response.body);
        Get.snackbar("Error",
            "Failed to add fitur. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  Future<void> updateFitur(int laundryId) async {
    try {
      final url = ConfigEnvironments.getEnvironments()["url"];
      final token = box.read('token');

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      };

      final response = await http.put(
        Uri.parse('$url/admin/laundry/update'),
        headers: headers,
        body: json.encode({
          'laundry_id': laundryId,
          'nama_laundry': namaLaundry.value.toString(),
          'harga': harga.value.toString(),
          'estimasi_waktu': estimasiWaktu.value.toString(),
          'deskripsi': deskripsi.value.toString(),
          'is_active': status.value ? '1' : '0',
        }),
      );

      if (response.statusCode == 200) {
        fetchFitur();
        clearText();
        Get.snackbar("Success", "Fitur updated successfully");
      } else {
        Get.snackbar("Error",
            "Failed to update fitur. Status code: ${response.statusCode}");
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
        Get.snackbar("Error",
            "Failed to delete fitur. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  String formatPrice(String price) {
    final formatter = NumberFormat.currency(locale: "id_ID", symbol: "Rp ", decimalDigits: 0);
    return formatter.format(double.parse(price));
  }

  Future<void> refreshFitur() async {
    isRefreshing(true);
    await fetchFitur();
    isRefreshing(false);
  }

  Future<void> updateServis(dynamic data) async {
    namaLaundryController.text = data['nama_laundry'].toString();
    hargaController.text = data['harga'].toString();
    estimasiWaktuController.text = data['estimasi_waktu'].toString();
    deskripsiController.text = data['deskripsi'].toString();
    status.value = data['is_active'];

    namaLaundry.value = data['nama_laundry'].toString();
    harga.value = data['harga'].toString();
    estimasiWaktu.value = data['estimasi_waktu'].toString();
    deskripsi.value = data['deskripsi'].toString();
    status.value = data['is_active'];
  }

  Future<void> clearText() async {
    namaLaundryController.clear();
    hargaController.clear();
    estimasiWaktuController.clear();
    deskripsiController.clear();
  }
}
