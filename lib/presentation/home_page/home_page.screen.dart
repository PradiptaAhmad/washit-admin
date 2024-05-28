import 'package:flutter/material.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/home_page/widgets/main_data_visual_widget.dart';
import 'package:washit_admin/presentation/home_page/widgets/newest_transaction_widget.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Selamat Datang",
                            style: tsLabelLargeSemibold(darkGrey)),
                        Text("Bapak Bajuri",
                            style: tsTitleMediumSemibold(black)),
                      ],
                    ),
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
                  controller: _tabController,
                  splashBorderRadius: BorderRadius.circular(50),
                  indicator: CircleTabIndicator(
                    color: black,
                    radius: 4,
                  ),
                  tabs: const [
                    Tab(text: "Order"),
                    Tab(text: "Transaction"),
                    Tab(text: "Berlangsung"),
                  ],
                ),
              ),
              SizedBox(
                height: screenHeight * screenWidth,
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    Column(
                      children: [
                        MainDataVisualWidget(),
                        NewestTransactionWidget(),
                      ],
                    ),
                    Text("His"),
                    Text("Hiz"),
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
