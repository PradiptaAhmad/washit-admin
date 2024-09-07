import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:washit_admin/presentation/user_detail_page/controllers/user_detail_page.controller.dart';
import 'package:washit_admin/widget/shimmer/shimmer_widget.dart';

import '../../infrastructure/theme/themes.dart';
import '../../widget/common/main_container_widget.dart';
import '../../widget/common/mainpage_appbar_widget.dart';

class UserDetailPage extends GetView<UserDetailPageController> {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainpageAppbarWidget(
        title: 'Detail Pengguna',
      ),
      body: RefreshIndicator(
        onRefresh: () async => controller.fetchUserDetailData(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Obx(
            () => !controller.isLoading.isTrue
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(height: 30),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      height: 120,
                                      width: 120,
                                      child: Image.network(
                                        controller.userDetailData[
                                                    'image_path'] ==
                                                null
                                            ? 'https://ui-avatars.com/api/?name=${controller.userDetailData['username']}&background=random&size=128'
                                            : 'https://pradiptaahmad.tech/image/${controller.userDetailData['image_path']}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "${controller.userDetailData['username'] ?? "Marlen"}",
                                    style: tsBodyLargeMedium(black),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Aktif Sejak - ${DateFormat('d MMMM yyyy', 'id_ID').format(DateTime.parse(controller.userDetailData['created_at'].toString()))}",
                                    style: tsLabelLargeMedium(darkGrey),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Text("INFORMASI PENGGUNA",
                            style: tsBodySmallSemibold(grey)),
                        SizedBox(height: 10),
                        MainContainerWidget(
                          padding: EdgeInsets.all(15),
                          childs: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailItem(context, "Email",
                                  "${controller.userDetailData['email'] ?? "default@gmail.com"}"),
                              SizedBox(height: 10),
                              _buildDetailItem(
                                context,
                                "No. Ponsel",
                                "${controller.userDetailData['phone'] ?? "08123456789"}",
                                isPhone: true,
                              ),
                              SizedBox(height: 10),
                              _buildDetailItem(
                                context,
                                "Alamat",
                                controller.userDetailData['address'] == null
                                    ? "Alamat tidak tersedia"
                                    : controller.userDetailData['address'],
                              ),
                              _buildDetailItem(
                                  context,
                                  "Jumlah Pesanan",
                                  controller.userDetailData['order_count']
                                      .toString()),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  )
                : _shimmerItemBuild(),
          ),
        ),
      ),
    );
  }
}

Widget _shimmerItemBuild() {
  return Center(
    child: Column(
      children: [
        SizedBox(height: 30),
        ShimmerWidget(
          radius: 20.00,
          height: 120,
          width: 120,
        ),
        SizedBox(height: 15),
        ShimmerWidget(
          radius: 20.00,
          height: 25,
          width: 200,
        ),
        SizedBox(height: 5),
        ShimmerWidget(
          radius: 20.00,
          height: 15,
          width: 150,
        )
      ],
    ),
  );
}

Widget _buildDetailItem(BuildContext context, String leftText, String rightText,
    {bool isPhone = false}) {
  return Row(
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
        child: GestureDetector(
          onTap: isPhone ? () => _launchPhone(rightText) : null,
          child: Text(
            rightText,
            style:
                tsBodySmallMedium(isPhone ? Colors.blue : darkGrey).copyWith(),
            textAlign: TextAlign.right,
          ),
        ),
      ),
    ],
  );
}

void _launchPhone(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
