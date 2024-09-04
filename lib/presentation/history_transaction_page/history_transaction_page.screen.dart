import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:washit_admin/presentation/history_transaction_page/history_transaction_detail_page.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import 'package:washit_admin/widget/shimmer/shimmer_widget.dart';

import '../../infrastructure/theme/themes.dart';
import 'controllers/history_transaction_page.controller.dart';

class HistoryTransactionPage extends GetView<HistoryTransactionPageController> {
  const HistoryTransactionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HistoryTransactionPageController controller =
        Get.put(HistoryTransactionPageController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + screenHeight(context) * 0.16,
        flexibleSpace:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppBar(
            backgroundColor: secondaryColor,
            title: Text('Transaksi', style: tsTitleSmallMedium(primaryColor)),
          ),
          SizedBox(height: 10),
          _appbarMain(controller),
        ]),
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.onRefresh(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            children: [
              Obx(() {
                if (controller.isLoading.isTrue) {
                  return ListView.builder(
                    itemCount: 6,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return _shimmerItemList();
                    },
                  );
                }
                return ListView.builder(
                  itemCount: controller.transactionList.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var transaction = controller.transactionList[index];
                    return _buildItemList(transaction);
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}

Widget _shimmerItemList() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: ShimmerWidget(
      radius: 10,
      height: 100,
    ),
  );
}

Widget _buildItemList(transaction) {
  return MainContainerWidget(
    onPressed: () => Get.to(HistoryTransactionDetailPage(
      id: transaction['id'],
      paymentType: transaction['payment_type'],
      externalId: transaction['external_id'],
      status: transaction['status'],
      amount: transaction['amount'],
      paymentId: transaction['payment_id'],
      paymentChannel: transaction['payment_channel'],
      description: transaction['description'],
      paidAt: transaction['paid_at'],
    )),
    margin: EdgeInsets.only(bottom: 10),
    padding: EdgeInsets.all(15),
    childs: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${transaction['payment_channel']}",
            style: tsBodyMediumMedium(black)),
        Text(
            "Dibayar pada tanggal ${DateFormat('d MMMM yyyy', 'id_ID').format(DateTime.parse(transaction['paid_at']))}",
            style: tsLabelLargeMedium(darkGrey)),
        Text(
          "Rp. ${transaction['amount']}",
          style: tsBodyMediumSemibold(secondaryColor),
        ),
      ],
    ),
  );
}

Widget _appbarMain(HistoryTransactionPageController controller) {
  return Obx(
    () => !controller.isLoading.isTrue
        ? MainContainerWidget(
            color: secondaryColor,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.symmetric(horizontal: 15),
            childs: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Pendapatan',
                  style: tsBodyMediumMedium(primaryColor),
                ),
                Text(
                  'Rp. ${controller.sumTransaction.value}',
                  style: tsHeadlineMediumSemibold(primaryColor),
                ),
                Text('Total Transaksi ${controller.sumTransactionCount.value}',
                    style: tsBodySmallRegular(primaryColor)),
              ],
            ),
          )
        : ShimmerWidget(
            margin: 15.00,
            radius: 10,
            height: 114,
          ),
  );
}
