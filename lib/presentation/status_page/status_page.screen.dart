import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:washit_admin/presentation/status_page/widgets/status_categories_button_widget.dart';
import 'package:washit_admin/widget/shimmer/shimmer_widget.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/themes.dart';
import '../../widget/common/main_container_widget.dart';
import 'controllers/status_page.controller.dart';

const double defaultMargin = 15.0;

class StatusPageScreen extends GetView<StatusPageController> {
  const StatusPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StatusPageController controller = Get.put(StatusPageController());
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: secondaryColor,
              title: Text('Status Pesanan',
                  style: tsTitleSmallMedium(primaryColor)),
            ),
            SizedBox(height: 10),
            StatusCategoriesButtonWidget(controller: controller),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchOrders();
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isPortrait = constraints.maxWidth < constraints.maxHeight;
            final padding = isPortrait
                ? EdgeInsets.symmetric(horizontal: defaultMargin)
                : EdgeInsets.symmetric(horizontal: 32);
            final itemHeight = isPortrait ? 200.0 : 160.0;

            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
            controller: controller.scrollController,
              child: Padding(
                padding: padding,
                child: Obx(
                      () {
                    if (controller.isLoading.value) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.selectedFilter.value == 0
                            ? controller.ordersList.length
                            : controller.filteredOrdersList.length,
                        itemBuilder: (context, index) => Padding(
                          padding: EdgeInsets.only(bottom: defaultMargin),
                          child: Container(
                            height: itemHeight,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.04),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.ordersList.length,
                        shrinkWrap: true,
                        reverse: true,
                        itemBuilder: (context, index) {
                          final order = controller.ordersList[index];
                        return Obx(() {
                          if (controller.isLoadingMore.value == true &&
                              index == controller.ordersList.length) {
                            return CupertinoActivityIndicator();
                          } else {
                            return Padding(
                              padding: EdgeInsets.only(bottom: defaultMargin),
                              child: InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    Routes.TRANSACTION_PAGE,
                                    arguments: controller.ordersList[index],
                                  );
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: MainContainerWidget(
                                  childs: Padding(
                                    padding: EdgeInsets.all(defaultMargin),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "id Pesanan",
                                                    style: tsLabelLargeMedium(
                                                        grey),
                                                  ),
                                                  Text(
                                                    "${order['no_pemesanan']}",
                                                    style: tsLabelLargeMedium(
                                                        black),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // Space between id and estimasi
                                            Expanded(
                                              flex: 1,
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Text(
                                                  "Estimasi: ${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(order['tanggal_estimasi'].toString()))}",
                                                  style: tsLabelLargeMedium(
                                                      darkGrey),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 1),
                                          child: Divider(
                                              color: lightGrey, thickness: 0.5),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              flex: isPortrait ? 2 : 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${order['nama_pemesan']}",
                                                    style: tsBodySmallSemibold(
                                                        black),
                                                  ),
                                                  Text(
                                                    order['jenis_pemesanan'] ==
                                                            'antar_jemput'
                                                        ? 'Antar Jemput'
                                                        : 'Antar Sendiri',
                                                    style: tsLabelLargeSemibold(
                                                        darkGrey),
                                                  ),
                                                  Text(
                                                    order['berat_laundry'] ==
                                                            null
                                                        ? "Berat belum tercatat"
                                                        : "${order['berat_laundry']} Kg",
                                                    style: tsLabelLargeSemibold(
                                                        darkGrey),
                                                  ),
                                                  Text(
                                                    "${order['nama_laundry']}",
                                                    style: tsBodySmallSemibold(
                                                        successColor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (isPortrait)
                                              Expanded(
                                                child: Text(
                                                  "${order['alamat']}",
                                                  style: tsLabelLargeSemibold(
                                                      grey),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.right,
                                                  maxLines: 4,
                                                ),
                                              )
                                            else
                                              Container(
                                                width: 120,
                                                child: Text(
                                                  "${order['alamat']}",
                                                  style: tsLabelLargeSemibold(
                                                      grey),
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.right,
                                                  maxLines: 4,
                                                ),
                                              ),
                                          ],
                                        ),
                                        SizedBox(height: 18),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Total harga",
                                                  style: tsLabelMediumMedium(
                                                      black),
                                                ),
                                                Text(
                                                  order['total_harga'] == null
                                                      ? "Belum tercatat"
                                                      : "${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(order['total_harga'])}",
                                                  style: tsBodySmallSemibold(
                                                      black),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  "Status laundry",
                                                  style: tsLabelMediumMedium(
                                                      black),
                                                ),
                                                Text(
                                                  '${order['status']}',
                                                  style: tsBodySmallSemibold(
                                                      secondaryColor),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        });
                          
                        },
                      );
                    }
                  },
                ),
              ),
            );
          }),
      ),
    );
  }
}

Widget _shimmerItemList() {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 4,
    itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(bottom: defaultMargin),
        child: ShimmerWidget(radius: 10, height: 200)),
  );
}

Widget DataIsEmpty(description) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Ooops!",
          style: tsHeadlineSmallMedium(darkGrey),
        ),
        Text(
          description,
          style: tsLabelLargeSemibold(grey),
        ),
      ],
    ),
  );
}

Widget _buildItemList(order) {
  Color statusColor;
  switch (order['status']) {
    case 'Pesanan Telah Dibuat':
      statusColor = pendingOrange;
      break;
    case 'Menunggu Penjemputan':
      statusColor = pendingOrange;
      break;
    case 'Sedang diproses':
      statusColor = pendingOrange;
      break;
    case 'Pesananmu akan segera diantar':
      statusColor = darkBlue;
      break;
    case 'Pesananmu Sedang Diantar':
      statusColor = Colors.blue;
      break;
    case 'Pesanan telah diantar':
      statusColor = successColor;
      break;
    default:
      statusColor = darkGrey;
  }

  return Padding(
    padding: EdgeInsets.only(bottom: defaultMargin),
    child: InkWell(
      onTap: () {
        Get.toNamed(
          Routes.TRANSACTION_PAGE,
          arguments: order['id'],
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: MainContainerWidget(
        childs: Padding(
          padding: EdgeInsets.all(defaultMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "id Pesanan",
                          style: tsLabelLargeMedium(grey),
                        ),
                        Text(
                          "${order['no_pemesanan']}",
                          style: tsLabelLargeMedium(black),
                        ),
                      ],
                    ),
                  ),
                  // Space between id and estimasi
                  Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Estimasi: ${DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.parse(order['tanggal_estimasi'].toString()))}",
                        style: tsLabelLargeMedium(darkGrey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1),
                child: Divider(color: lightGrey, thickness: 0.5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${order['nama_pemesan']}",
                          style: tsBodySmallSemibold(black),
                        ),
                        Text(
                          order['jenis_pemesanan'] == 'antar_jemput'
                              ? 'Antar Jemput'
                              : 'Antar Sendiri',
                          style: tsLabelLargeSemibold(darkGrey),
                        ),
                        Text(
                          order['berat_laundry'] == null
                              ? "Berat belum tercatat"
                              : "${order['berat_laundry']} Kg",
                          style: tsLabelLargeSemibold(darkGrey),
                        ),
                        Text(
                          "${order['nama_laundry']}",
                          style: tsBodySmallSemibold(successColor),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      "${order['alamat']}",
                      style: tsLabelLargeSemibold(grey),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      maxLines: 4,
                    ),
                  )
                ],
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total harga",
                        style: tsLabelMediumMedium(black),
                      ),
                      Text(
                        order['total_harga'] == null
                            ? "Belum tercatat"
                            : "${NumberFormat.currency(locale: 'id', symbol: 'Rp', decimalDigits: 0).format(order['total_harga'])}",
                        style: tsBodySmallSemibold(black),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Status laundry",
                        style: tsLabelMediumMedium(black),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: statusColor.withOpacity(0.1),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '${order['status']}',
                          style: tsBodySmallSemibold(statusColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
