import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/home_page/controllers/home_page.controller.dart';
import 'package:washit_admin/presentation/home_page/widgets/main_data_visual_widget.dart';
import 'package:washit_admin/presentation/home_page/widgets/newest_activity_widget.dart';
import 'package:washit_admin/presentation/home_page/widgets/overview_visual_data_widget.dart';

import '../../widget/common/circle_tab_indicator.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomePageController>();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: defaultMargin,
                    right: defaultMargin,
                    top: defaultMargin,
                    bottom: defaultMargin / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Selamat Datang",
                                style: tsLabelLargeSemibold(darkGrey)),
                            Text(
                                controller.isLoading.value
                                    ? "Loading..."
                                    : "${controller.userData['username']}",
                                style: tsTitleMediumSemibold(black)),
                          ],
                        )),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: grey,
                      ),
                      height: 45,
                      width: 45,
                      child: const Icon(
                        Icons.person,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                child: TabBar(
                  labelColor: black,
                  unselectedLabelColor: darkGrey,
                  indicatorColor: secondaryColor,
                  dividerColor: Colors.transparent,
                  labelStyle: tsBodySmallSemibold(black),
                  controller: _tabController,
                  splashBorderRadius: BorderRadius.circular(50),
                  indicator: CircleTabIndicator(
                    color: black,
                    radius: 4,
                  ),
                  tabs: const [
                    Tab(text: "Overview"),
                    Tab(text: "Order"),
                    Tab(text: "Transaksi"),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * screenWidth,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    OverviewVisualDataWidget(),
                    Column(
                      children: [
                        MainDataVisualWidget(
                          title1: "Hari Ini",
                          desc1: "11",
                          title2: "Bulan Ini",
                          desc2: "25",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(10)),
                          height: 1,
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        NewestTransactionWidget(
                          mainTitle: "Invoice Pemesanan",
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        MainDataVisualWidget(
                          title1: "Hari Ini",
                          desc1: "25000",
                          title2: "Bulan Ini",
                          desc2: "250000",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(10)),
                          height: 1,
                          width: double.infinity,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        NewestTransactionWidget(
                          mainTitle: "Invoice Transaksi",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
