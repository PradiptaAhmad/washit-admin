import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:washit_admin/presentation/home_page/models/OrdersModel.dart';
import '../../../config.dart';
import '../../../infrastructure/navigation/routes.dart';
import 'package:http/http.dart' as http;

class OrverviewMainController extends GetxController {
  var ordersList = [].obs;
  var jenisList = <String>[].obs;
  var isLoading = false.obs;

  // Init variable
  final url = ConfigEnvironments.getEnvironments()["url"];
  final box = GetStorage();

  // Map<String, dynamic> detailtrasaction(int index, OrdersModel product) {
  //   return {
  //     'index': index,
  //     'id': product.id,
  //     'no_pemesanan': product.noPemesanan,
  //     'jenis_pemesanan': product.jenisPemesanan,
  //     'nama_pemesan': product.namaPemesan,
  //     'nomor_telepon': product.nomorTelepon,
  //     'alamat': product.alamat,
  //     'berat_laundry': product.beratLaundry,
  //     'total_harga': product.totalHarga,
  //     'payment_method': product.paymentMethod,
  //     'tanggal_pemesanan': product.tanggalPemesanan?.substring(0, product.tanggalPemesanan!.length - 3) ?? '',
  //     'tanggal_pengambilan': product.tanggalPengambilan,
  //     'laundry_id': product.laundryId,
  //   };
  // }

  Future<void> fetchOrders() async {
    final url = ConfigEnvironments.getEnvironments()["url"];
    final token = box.read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };

    var response = await http.get(
      Uri.parse("$url/admin/orders/all"),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body)['orders'] as List<dynamic>;
      ordersList.assignAll(data);
    } else {
      Get.snackbar("Gagal Mengambil Data", "Silahkan coba lagi",
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.red);
    }
  }

  // void goToDetailTransactionPage(int index) {
  //   var product = ordersList[index];
  //   var productDetail = detailtrasaction(index, product);

  //   Get.toNamed(Routes.TRANSACTION_PAGE, arguments: productDetail);
  // }

  @override
  void onInit() {
    isLoading.value = true;
    // Implement feature
    fetchOrders();
    isLoading.value = false;
    super.onInit();
  }

}



