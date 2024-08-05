import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/transaction_page/widget/detail_text_widget.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import 'package:washit_admin/widget/common/mainpage_appbar_widget.dart';
import 'controllers/transaction_page.controller.dart';

class TransactionPageScreen extends GetView<TransactionPageController> {
  TransactionPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainpageAppbarWidget(
        title: 'Detail Transaksi',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainContainerWidget(
              width: double.infinity,
              childs: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    OrderStatusIcons(),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            MainContainerWidget(
              width: double.infinity,
              childs: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    DetailDataWidget(
                      leftTitle: "Status Pemesanan",
                      leftTitleStyle: tsBodySmallSemibold(black),
                      rightTitle: "",
                    ),
                    SizedBox(height: 10),
                    DetailDataWidget(
                      leftTitle: "Tanggal Pemesanan",
                      rightTitle: "25-03-2024",
                    ),
                    SizedBox(height: 5),
                    DetailDataWidget(
                      leftTitle: "Tanggal Estimasi",
                      rightTitle: "28-03-2024",
                    ),
                    SizedBox(height: 5),
                    DetailDataWidget(
                      leftTitle: "Tanggal Pembayaran",
                      rightTitle: "27-03-2024 12:22:12",
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            MainContainerWidget(
              width: double.infinity,
              childs: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    DetailDataWidget(
                      leftTitle: "Info Pemesanan",
                      leftTitleStyle: tsBodySmallSemibold(black),
                      rightTitle: "",
                    ),
                    SizedBox(height: 10),
                    DetailDataWidget(
                      leftTitle: "Nama",
                      rightTitle: "Marlen",
                      textTitleOverflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 5),
                    DetailDataWidget(
                      leftTitle: "No. Pemesanan",
                      rightTitle: "ORD001",
                    ),
                    SizedBox(height: 5),
                    DetailDataWidget(
                      leftTitle: "Tipe Laundry",
                      rightTitle: "Cuci Setrika",
                    ),
                    SizedBox(height: 5),
                    DetailDataWidget(
                      leftTitle: "Berat Laundry",
                      rightTitle: "Berat Belum Tercatat",
                    ),
                    SizedBox(height: 5),
                    DetailDataWidget(
                      leftTitle: "Catatan",
                      rightTitle: "Tidak ada catatan",
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            MainContainerWidget(
              width: double.infinity,
              childs: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    DetailDataWidget(
                      leftTitle: "Info Pengiriman",
                      leftTitleStyle: tsBodySmallSemibold(black),
                      rightTitle: "",
                    ),
                    SizedBox(height: 10),
                    DetailDataWidget(
                      leftTitle: "Nomor Ponsel",
                      rightTitle: "082337771",
                      textTitleOverflow: TextOverflow.visible,
                    ),
                    SizedBox(height: 5),
                    DetailDataWidget(
                      leftTitle: "Alamat",
                      rightTitle: "Jl.Pala no 108, Binagritya blok A, Medono, Pekalongan Barat, Pekalongan, Indonesia",
                      textTitleOverflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            MainContainerWidget(
              width: double.infinity,
              childs: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    DetailDataWidget(
                      leftTitle: "Metode Pembayaran",
                      rightTitle: "Cashless",
                    ),
                    SizedBox(height: 5),
                    DetailDataWidget(
                      leftTitle: "Harga Laundry",
                      rightTitle: "Harga Belum Tercatat",
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Divider(color: lightGrey, thickness: 0.5),
                    ),
                    DetailDataWidget(
                      leftTitle: "Total Harga",
                      rightTitle: "Harga Belum Tercatat",
                    ),
                    SizedBox(height: 5),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderStatusIcons extends StatelessWidget {
  const OrderStatusIcons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Iconsax.receipt,
              size: 30,
              color: successColor,
            ),
            DottedLine(
              direction: Axis.horizontal,
              lineLength: 40,
              lineThickness: 2,
              dashLength: 5,
              dashColor: successColor,
            ),
            Icon(
              Iconsax.wallet_1,
              size: 30,
              color: successColor,
            ),
            DottedLine(
              direction: Axis.horizontal,
              lineLength: 40,
              lineThickness: 2,
              dashLength: 5,
              dashColor: successColor,
            ),
            Icon(
              Iconsax.bubble,
              size: 30,
              color: successColor,
            ),
            DottedLine(
              direction: Axis.horizontal,
              lineLength: 40,
              lineThickness: 2,
              dashLength: 5,
              dashColor: successColor,
            ),
            Icon(
              Iconsax.location,
              size: 30,
              color: successColor,
            ),
            DottedLine(
              direction: Axis.horizontal,
              lineLength: 40,
              lineThickness: 2,
              dashLength: 5,
              dashColor: successColor,
            ),
            Icon(
              Iconsax.verify,
              size: 30,
              color: successColor,
            ),
          ],
        ),
        SizedBox(height: 10),
        Text(
          "Laundry telah diterima",
          style: tsBodySmallMedium(black),
        ),
      ],
    );
  }
}
