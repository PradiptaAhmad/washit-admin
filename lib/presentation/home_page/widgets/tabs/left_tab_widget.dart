import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/navigation/routes.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import 'package:washit_admin/widget/shimmer/shimmer_widget.dart';

import '../../../../infrastructure/theme/themes.dart';
import '../../../../widget/common/content_title_widget.dart';
import '../../controllers/home_page.controller.dart';
import '../overview_main_chart_bar.dart';

class LeftTabWidget extends GetView<HomePageController> {
  const LeftTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => controller.onRefresh(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          visualCardWidget(
                              controller,
                              "TOTAL PENGGUNA",
                              controller.overviewData['total_users']
                                  .toString()),
                          visualCardWidget(controller, "TOTAL PENDAPATAN",
                              "Rp${controller.overviewData['total_transactions']}"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          visualCardWidget(
                              controller,
                              "TOTAL PESANAN",
                              controller.overviewData['total_orders']
                                  .toString()),
                          visualCardWidget(controller, "TOTAL RATING",
                              controller.overviewData['average_ratings']),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ContentTitleWidget(
                  title: "SERVICE",
                  lefttextSize: tsBodySmallSemibold(grey),
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes.FITUR_PAGE);
                },
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: MainContainerWidget(
                    padding: EdgeInsets.all(10),
                    childs: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(
                                Icons.local_laundry_service_rounded,
                                color: Colors.blue,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Fitur Layanan",
                                    style: tsBodySmallMedium(black)),
                                Text(
                                  "Tambah atau edit fitur layanan",
                                  style: tsLabelLargeMedium(darkGrey),
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
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: ContentTitleWidget(
                  title: "PESANAN BARU",
                  lefttextSize: tsBodySmallSemibold(grey),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: OverviewMainChartBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget visualCardWidget(HomePageController controller, title, desc) {
  return Obx(
    () => !controller.isLoading.isTrue || controller.overviewData.isEmpty
        ? MainContainerWidget(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(10),
            childs: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "${title}",
                        style: tsLabelLargeMedium(grey),
                        overflow: TextOverflow.ellipsis, // Prevent overflow
                      ),
                    ),
                  ],
                ),
                Text("${desc}", style: tsTitleLargeSemibold(black)),
                SizedBox(height: 10),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(5.0),
            child: ShimmerWidget(
              height: 100,
              radius: 10,
            ),
          ),
  );
}
