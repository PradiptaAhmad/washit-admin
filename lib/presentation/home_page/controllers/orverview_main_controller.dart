import 'dart:convert';
import 'package:get/get.dart';
import 'package:washit_admin/presentation/home_page/models/OrdersModel.dart';
import '../../../config.dart';
import '../../../infrastructure/navigation/routes.dart';

class OrverviewMainController extends GetxController {
  var ordersList = <OrdersModel>[].obs;
  var jenisList = <String>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }



  Map<String, dynamic> detailtrasaction(int index, OrdersModel product) {
    return {
      'index': index,
      'id': product.id,
      'no_pemesanan': product.noPemesanan,
      'jenis_pemesanan': product.jenisPemesanan,
      'nama_pemesan': product.namaPemesan,
      'nomor_telepon': product.nomorTelepon,
      'alamat': product.alamat,
      'berat_laundry': product.beratLaundry,
      'total_harga': product.totalHarga,
      'payment_method': product.paymentMethod,
      'tanggal_pemesanan': product.tanggalPemesanan?.substring(0, product.tanggalPemesanan!.length - 3) ?? '',
      'tanggal_pengambilan': product.tanggalPengambilan,
      'laundry_id': product.laundryId,
    };
  }

  void goToDetailTransactionPage(int index) {
    var product = ordersList[index];
    var productDetail = detailtrasaction(index, product);

    Get.toNamed(Routes.TRANSACTION_PAGE, arguments: productDetail);
  }
}

