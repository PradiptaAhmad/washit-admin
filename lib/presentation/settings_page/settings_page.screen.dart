import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/navigation/routes.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/settings_page/controllers/settings_page.controller.dart';
import 'package:washit_admin/presentation/settings_page/setting_change_page.dart';
import 'package:washit_admin/widget/common/content_title_widget.dart';

import '../../widget/shimmer/shimmer_widget.dart';

class SettingPage extends GetView<SettingController> {
  SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => controller.onRefresh(),
          child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(defaultMargin),
              child: _buildProfileItemList(context, controller)),
        ),
      ),
    );
  }
}

Widget _buildProfileItemList(
  BuildContext context,
  SettingController controller,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Column(
          children: [
            Obx(
              () => !controller.isLoading.isTrue
                  ? CircleAvatar(
                      radius: 40,
                      backgroundColor: grey,
                      backgroundImage: NetworkImage(
                        controller.adminData['image_path'] == null
                            ? 'https://ui-avatars.com/api/?name=${controller.adminData['username']}&background=random&size=128'
                            : 'https://api.laundrynaruto.my.id/image/${controller.adminData['image_path']}',
                      ),
                    )
                  : ShimmerWidget(
                      radius: 40,
                      width: 80,
                      height: 80,
                    ),
            ),
            SizedBox(height: 5),
            Obx(
              () => !controller.isLoading.isTrue
                  ? InkWell(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: Text(
                        "Ubah foto profil",
                        style: tsBodySmallSemibold(successColor),
                      ),
                    )
                  : ShimmerWidget(
                      radius: 8,
                      width: 100,
                      height: 20,
                    ),
            ),
          ],
        ),
      ),
      SizedBox(height: 5),
      Divider(color: lightGrey, thickness: 1),
      SizedBox(height: 20),
      Obx(
        () => !controller.isLoading.value
            ? ContentTitleWidget(
                title: "Info Profil",
                lefttextSize: tsBodyMediumMedium(black),
              )
            : ShimmerWidget(
                radius: 10,
                width: 80,
                height: 21,
              ),
      ),
      SizedBox(height: 20),
      Obx(() => !controller.isLoading.isTrue
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Username', style: tsBodySmallRegular(darkGrey)),
                InkWell(
                  onTap: () => Get.to(
                    SettingChangePage(
                      title: 'Username',
                      hintText: controller.adminData['username'],
                      validator: (newValue) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          controller.adminData['username'] = newValue;
                        });
                        return null;
                      },
                      onTap: () {
                        controller.fetchUpdateAccount();
                        Get.back();
                      },
                    ),
                  )!
                      .then((value) {
                    controller.fetchAdminData();
                  }),
                  child: Row(
                    children: [
                      Text('${controller.adminData['username']}',
                          overflow: TextOverflow.ellipsis,
                          style: tsBodySmallRegular(black)),
                      SizedBox(width: 20),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: darkGrey,
                        size: 15,
                      ),
                    ],
                  ),
                )
              ],
            )
          : shimmerInfoList()),
      SizedBox(height: 20),
      Obx(
        () => !controller.isLoading.isTrue
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Email', style: tsBodySmallRegular(darkGrey)),
                  InkWell(
                    onTap: () async {
                      Get.to(SettingChangePage(
                        title: 'Email',
                        hintText: controller.adminData['email'],
                        validator: (newValue) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            controller.adminData['email'] = newValue;
                          });
                          return null;
                        },
                        onTap: () {
                          controller.fetchUpdateAccount();
                          Get.back();
                        },
                      ))!
                          .then((value) {
                        controller.fetchAdminData();
                      });
                    },
                    child: Row(
                      children: [
                        Text('${controller.adminData['email']}',
                            style: tsBodySmallRegular(black)),
                        SizedBox(width: 20),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkGrey,
                          size: 15,
                        ),
                      ],
                    ),
                  )
                ],
              )
            : shimmerInfoList(),
      ),
      SizedBox(height: 20),
      Obx(
        () => !controller.isLoading.isTrue
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Nomor Telepon', style: tsBodySmallRegular(darkGrey)),
                  InkWell(
                    onTap: () => Get.to(
                      SettingChangePage(
                        title: 'Nomor Telepon',
                        hintText: controller.adminData['phone'],
                        validator: (newValue) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            controller.adminData['phone'] = newValue;
                          });
                          return null;
                        },
                        onTap: () {
                          controller.fetchUpdateAccount();
                          Get.back();
                        },
                      ),
                    )!
                        .then((value) {
                      controller.fetchAdminData();
                    }),
                    child: Row(
                      children: [
                        Text('${controller.adminData['phone']}',
                            style: tsBodySmallRegular(black)),
                        SizedBox(width: 20),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkGrey,
                          size: 15,
                        ),
                      ],
                    ),
                  )
                ],
              )
            : shimmerInfoList(),
      ),
      SizedBox(height: 20),
      Obx(
        () => !controller.isLoading.isTrue
            ? InkWell(
                onTap: () => Get.toNamed(Routes.USERS_PAGE),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pengguna', style: tsBodySmallRegular(darkGrey)),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: darkGrey,
                      size: 15,
                    )
                  ],
                ),
              )
            : shimmerInfoList(),
      ),
      SizedBox(height: 20),
      Obx(
        () => !controller.isLoading.value
            ? ContentTitleWidget(
                title: "Lainnya",
                lefttextSize: tsBodyMediumMedium(black),
              )
            : ShimmerWidget(
                radius: 10,
                width: 80,
                height: 22,
              ),
      ),
      SizedBox(height: 20),
      Obx(
        () => !controller.isLoading.value
            ? InkWell(
                onTap: () => controller.showExitConfirmationDialog(context),
                child: Text('Keluar akun',
                    style: tsBodySmallRegular(warningColor)),
              )
            : ShimmerWidget(
                radius: 8,
                width: 100,
                height: 20,
              ),
      ),
    ],
  );
}

Widget shimmerInfoList() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ShimmerWidget(
        radius: 8,
        width: 100,
        height: 18,
      ),
      ShimmerWidget(
        radius: 8,
        width: 180,
        height: 18,
      ),
    ],
  );
}
