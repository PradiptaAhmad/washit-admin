import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:washit_admin/widget/common/custom_pop_up.dart';

import '../../../config.dart';
import '../../../infrastructure/theme/themes.dart';

class FiturController extends GetxController {
  // Important
  var isLoading = false.obs;
  var isRefreshing = false.obs;
  GetStorage box = GetStorage();

  // Var
  var serviceList = [].obs;
  var namaLaundry = ''.obs;
  var harga = ''.obs;
  var estimasiWaktu = ''.obs;
  var deskripsi = ''.obs;
  var status = true.obs;
  var namaLaundryController = TextEditingController();
  var hargaController = TextEditingController();
  var estimasiWaktuController = TextEditingController();
  var deskripsiController = TextEditingController();

  Future<void> fetchFitur() async {
    isLoading.value = true;
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
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk mengambil data Fitur', warningColor);
    } finally {
      isLoading.value = false;
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
      final response = await http.post(
        Uri.parse("${url}/admin/laundry/add"),
        headers: headers,
        body: data,
      );
      if (response.statusCode == 201) {
        fetchFitur();
        customPopUp('Sukses, berhasil untuk menambahkan fitur', successColor);
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk menambahkan Fitur', warningColor);
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
        customPopUp('Sukses, berhasil untuk memperbarui fitur', successColor);
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk memperbarui Fitur', warningColor);
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
        customPopUp('Sukses, berhasil untuk menghapus fitur', successColor);
      } else {
        customPopUp('Error, Kode:${response.statusCode}', warningColor);
      }
    } catch (e) {
      customPopUp('Error, gagal untuk menghapus Fitur', warningColor);
    }
  }

  String formatPrice(String price) {
    final formatter =
        NumberFormat.currency(locale: "id_ID", symbol: "Rp ", decimalDigits: 0);
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

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await fetchFitur();
    isLoading.value = false;
  }
}
