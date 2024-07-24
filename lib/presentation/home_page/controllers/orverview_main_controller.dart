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
    fetchOrdersData();
    super.onInit();
  }

  Future<void> fetchOrdersData() async {
    try {
      isLoading(true);
      await Future.delayed(Duration(seconds: 2));

      final OrdersData = [
        {
          'id': 1,
          'no_pemesanan': 'ORD001',
          'jenis_pemesanan': 'Cuci Setrika',
          'nama_pemesan': 'Marlen',
          'nomor_telepon': '082299134211',
          'alamat': 'Kudus',
          'berat_laundry': '3 kg',
          'total_harga': '100000',
          'payment_method': 'Cash',
          'tanggal_pemesanan': '19-05-2024',
          'tanggal_pengambilan': '25-05-2024',
          'laundry_id': '1',
          'user_id': '1',
          'created_at': '2024-07-22T00:00:00',
          'updated_at': '2024-07-22T00:00:00',
        },

        {
          'id': 2,
          'no_pemesanan': 'ORD002',
          'jenis_pemesanan': 'Cuci Setrika',
          'nama_pemesan': 'Abid',
          'nomor_telepon': '082172711',
          'alamat': 'Kudus',
          'berat_laundry': '2 kg',
          'total_harga': '100000',
          'payment_method': 'Cash',
          'tanggal_pemesanan': '20-05-2024',
          'tanggal_pengambilan': '21-05-2024',
          'laundry_id': '2',
          'user_id': '2',
          'created_at': '2024-07-22T00:00:00',
          'updated_at': '2024-07-22T00:00:00',
        },

        {
          'id': 3,
          'no_pemesanan': 'ORD003',
          'jenis_pemesanan': 'Cuci Setrika',
          'nama_pemesan': 'Adib',
          'nomor_telepon': '082172711',
          'alamat': 'Kudus',
          'berat_laundry': '3 kg',
          'total_harga': '100000',
          'payment_method': 'Cash',
          'tanggal_pemesanan': '22-05-2024',
          'tanggal_pengambilan': '24-05-2024',
          'laundry_id': '3',
          'user_id': '3',
          'created_at': '2024-07-22T00:00:00',
          'updated_at': '2024-07-22T00:00:00',
        },

        {
          'id': 4,
          'no_pemesanan': 'ORD004',
          'jenis_pemesanan': 'Cuci Setrika',
          'nama_pemesan': 'Vania',
          'nomor_telepon': '082921182',
          'alamat': 'Kudus',
          'berat_laundry': '5 kg',
          'total_harga': '20000',
          'payment_method': 'Cash',
          'tanggal_pemesanan': '27-05-2024',
          'tanggal_pengambilan': '29-05-2024',
          'laundry_id': '3',
          'user_id': '3',
          'created_at': '2024-07-22T00:00:00',
          'updated_at': '2024-07-22T00:00:00',
        },


      ];

      final JenisData = ['Laundry', 'Dry Cleaning', 'Ironing'];

      ordersList.value = OrdersData.map((order) => OrdersModel.fromJson(order)).toList();
      jenisList.value = JenisData;

    } catch (e) {
      Get.snackbar('Error', 'Failed to load orders');
    } finally {
      isLoading(false);
    }
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

