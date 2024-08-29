import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:slider_button/slider_button.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/transaction_page/widget/bottom_scroll_sheet_widget.dart';
import 'package:washit_admin/presentation/transaction_page/widget/detail_text_widget.dart';
import 'package:washit_admin/widget/common/button_widget.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import 'package:washit_admin/widget/common/mainpage_appbar_widget.dart';

import 'controllers/transaction_page.controller.dart';

class TransactionPageScreen extends GetView<TransactionPageController> {
  TransactionPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainpageAppbarWidget(
        title: 'Detail transaksi',
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            await controller.fetchDetailsOrder();
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenWidth = constraints.maxWidth;
              final screenHeight = constraints.maxHeight;

              return SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: defaultMargin,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: defaultMargin),
                    _buildDetailSection(
                      context,
                      title: "Status Pemesanan",
                      data: [
                        DetailDataWidget(
                          leftTitle: "Tanggal pemesanan",
                          rightTitle: "${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(controller.detailData['tanggal_pemesanan'] ?? "1443-07-31 00:00:00"))}",
                        ),
                        DetailDataWidget(
                          leftTitle: "Tanggal estimasi",
                          rightTitle: "${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(controller.detailData['tanggal_pengambilan'] ?? "2007-07-31 00:00:00"))}",
                        ),
                        DetailDataWidget(
                          leftTitle: "Tanggal pembayaran",
                          rightTitle: "27-03-2024 12:22:12",
                        ),
                      ],
                    ),
                    SizedBox(height: defaultMargin),
                    _buildDetailSection(
                      context,
                      title: "Info Pemesanan",
                      data: [
                        DetailDataWidget(
                          leftTitle: "Nama",
                          rightTitle: "${controller.detailData['nama_pemesan']}",
                          textTitleOverflow: TextOverflow.visible,
                        ),
                        DetailDataWidget(
                          leftTitle: "No. Pemesanan",
                          rightTitle: "${controller.detailData['no_pemesanan']}",
                        ),
                        DetailDataWidget(
                          leftTitle: "Jenis pemesanan",
                          rightTitle: controller.detailData['jenis_pemesanan'] == 'antar_mandiri' ? "Antar mandiri" : "Antar Jemput",
                        ),
                        DetailDataWidget(
                          leftTitle: "Tipe laundry",
                          rightTitle: controller.detailData['laundry_service'] ?? "Tidak ada tipe",
                        ),
                        DetailDataWidget(
                          leftTitle: "Berat laundry",
                          rightTitle: controller.detailData['berat_laundry'] == null ? "Berat belum tercatat" : "${controller.detailData['berat_laundry'].toString()} Kg",
                        ),
                        DetailDataWidget(
                          leftTitle: "Catatan",
                          rightTitle: controller.detailData['catatan'] ?? "Tidak ada catatan",
                        ),
                      ],
                    ),
                    if (controller.detailData['jenis_pemesanan'] != 'antar_mandiri')
                      SizedBox(height: defaultMargin),
                    if (controller.detailData['jenis_pemesanan'] != 'antar_mandiri')
                      _buildDetailSection(
                        context,
                        title: "Info Pengiriman",
                        data: [
                          DetailDataWidget(
                            leftTitle: "Nomor ponsel",
                            rightTitle: "${controller.detailData['nomor_telepon']}",
                            textTitleOverflow: TextOverflow.visible,
                          ),
                          DetailDataWidget(
                            leftTitle: "Alamat",
                            rightTitle: "${controller.detailData['alamat']}",
                            textTitleOverflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    SizedBox(height: defaultMargin),
                    _buildDetailSection(
                      context,
                      title: "Metode pembayaran",
                      data: [
                        DetailDataWidget(
                          leftTitle: "Metode pembayaran",
                          rightTitle: controller.detailData['metode_pembayaran'] == "tunai" ? "Tunai" : "Non Tunai",
                        ),
                        DetailDataWidget(
                          leftTitle: "Harga laundry",
                          rightTitle: "Rp 6.000 x ${controller.detailData['berat_laundry'] ?? '0'} Kg",
                        ),
                        DetailDataWidget(
                          leftTitle: "Total harga",
                          rightTitle: controller.detailData['total_harga'] == null
                              ? "Harga belum tercatat"
                              : "${NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(controller.detailData['total_harga'])}",
                        ),
                      ],
                    ),
                    SizedBox(height: defaultMargin),
                    SliderButton(
                      width: double.infinity,
                      action: () async {
                        controller.updateStatus();
                        return true;
                      },
                      icon: Text(">"),
                      label: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Update Status",
                          style: tsBodyMediumMedium(darkGrey),
                        ),
                      ),
                    ),
                    SizedBox(height: defaultMargin),
                    ButtonWidget(
                      onPressed: () => _showUpdateWeightSheet(context),
                      text: "Update Berat Laundry",
                      backgroundColor: secondaryColor,
                      textColor: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.update, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            "Update Berat Laundry",
                            style: tsBodyMediumRegular(black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }

  Widget _buildDetailSection(BuildContext context, {required String title, required List<Widget> data}) {
    return MainContainerWidget(
      width: double.infinity,
      childs: Padding(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            DetailDataWidget(
              leftTitle: title,
              leftTitleStyle: tsBodySmallSemibold(black),
              rightTitle: "",
            ),
            SizedBox(height: 10),
            ...data,
          ],
        ),
      ),
    );
  }

  void _showUpdateWeightSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return UpdateWeightBottomSheet();
      },
    );
  }
}

//    Visibility(
//        visible:
//        controller.argument[1] == 'histories' ? false : true,
//        child: MainContainerWidget(
//          width: double.infinity,
//        childs: Padding(
//          padding: const EdgeInsets.all(8.0),
//        child: Column(
//        children: [
//          SizedBox(height: 5),
//          OrderStatusIcons(controller: controller),
//        ],
//      ),
//    ),
//  ),
// ),

// class OrderStatusIcons extends StatelessWidget {
//   const OrderStatusIcons({
//     super.key,
//     required this.controller,
//   });
//
//   final TransactionPageController controller;
//
//   @override
//   Widget build(BuildContext context) {
//
//     final statusCode = controller.statusList['status_code'] ?? 0;
//
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Icon(
//               Iconsax.receipt,
//               size: 30,
//               color: statusCode >= 0 ? successColor : lightGrey,
//             ),
//             DottedLine(
//               direction: Axis.horizontal,
//               lineLength: 40,
//               lineThickness: 2,
//               dashLength: 5,
//               dashColor: statusCode >= 2 ? successColor : lightGrey,
//             ),
//             Icon(
//               Iconsax.wallet_1,
//               size: 30,
//               color: statusCode >= 2 ? successColor : lightGrey,
//             ),
//             DottedLine(
//               direction: Axis.horizontal,
//               lineLength: 40,
//               lineThickness: 2,
//               dashLength: 5,
//               dashColor: statusCode >= 3 ? successColor : lightGrey,
//             ),
//             Icon(
//               Iconsax.bubble,
//               size: 30,
//               color: statusCode >= 3 ? successColor : lightGrey,
//             ),
//             DottedLine(
//               direction: Axis.horizontal,
//               lineLength: 40,
//               lineThickness: 2,
//               dashLength: 5,
//               dashColor: statusCode >= 4 ? successColor : lightGrey,
//             ),
//             Icon(
//               Iconsax.location,
//               size: 30,
//               color: statusCode >= 4 ? successColor : lightGrey,
//             ),
//             DottedLine(
//               direction: Axis.horizontal,
//               lineLength: 40,
//               lineThickness: 2,
//               dashLength: 5,
//               dashColor: statusCode >= 5 ? successColor : lightGrey,
//             ),
//             Icon(
//               Iconsax.verify,
//               size: 30,
//               color: statusCode >= 5 ? successColor : lightGrey,
//             ),
//           ],
//         ),
//         SizedBox(height: 10),
//         Text(
//           "${controller.statusList['status_description']}",
//           style: tsBodySmallMedium(black),
//         ),
//       ],
//     );
//   }
// }

