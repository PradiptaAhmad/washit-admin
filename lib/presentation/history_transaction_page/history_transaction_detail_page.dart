import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/history_transaction_page/controllers/history_transaction_page.controller.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import 'package:washit_admin/widget/common/mainpage_appbar_widget.dart';

class HistoryTransactionDetailPage
    extends GetView<HistoryTransactionPageController> {
  const HistoryTransactionDetailPage({
    Key? key,
    this.id,
    this.paymentType,
    this.externalId,
    this.status,
    this.amount,
    this.paymentId,
    this.paymentChannel,
    this.description,
    this.paidAt,
  }) : super(key: key);

  final id;
  final paymentType;
  final externalId;
  final status;
  final amount;
  final paymentId;
  final paymentChannel;
  final description;
  final paidAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainpageAppbarWidget(title: 'Detail Pembayaran'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 10),
              MainContainerWidget(
                margin: EdgeInsets.symmetric(horizontal: defaultMargin),
                padding: EdgeInsets.all(15),
                childs: Column(
                  children: [
                    Text("Rp. ${amount}",
                        style: tsTitleLargeSemibold(secondaryColor)),
                    SizedBox(height: 20),
                    _buildDetailItem(
                        context,
                        'Tipe Pembayaran',
                        paymentType.toString() == 'non_tunai'
                            ? 'Non Tunai'
                            : 'Tunai'),
                    _buildDetailItem(
                        context, 'No. Referensi.', '${externalId}'),
                    _buildDetailItem(context, 'Status', '${status}'),
                    _buildDetailItem(
                        context, 'Metode Pembayaran', '${paymentChannel}'),
                    _buildDetailItem(context, 'Deskripsi', '${description}'),
                    _buildDetailItem(context, 'Dibayar Pada',
                        '${DateFormat('d MMMM yyyy, HH:mm', 'id_ID').format(DateTime.parse(paidAt.toString()))}'),
                    _buildDetailItem(context, 'Id Pembayaran', '${paymentId}'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDetailItem(context, leftText, rightText) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            leftText,
            style: tsBodySmallMedium(grey),
          ),
        ),
        Expanded(
          child: Text(
            rightText,
            style: tsBodySmallMedium(darkGrey),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}
