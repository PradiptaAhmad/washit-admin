import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/settings_page/controllers/settings_page.controller.dart';
import 'package:washit_admin/presentation/settings_page/setting_change_page.dart';
import 'package:washit_admin/widget/common/content_title_widget.dart';

class SettingPage extends GetView<SettingController> {
  SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.fetchAdminData();
            controller.updatePhotoProfile();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(defaultMargin),
            child: controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : Column(
              children: [
                ContentTitleWidget(
                  title: "Pengaturan Akun",
                  lefttextSize: tsTitleSmallMedium(black),
                ),
                SizedBox(height: 10),
                MainProfileWidget(),
                SizedBox(height: 5),
                Divider(color: lightGrey, thickness: 1),
                ContentTitleWidget(
                  title: "Detail Akun",
                  lefttextSize: tsBodyMediumMedium(black),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Username', style: tsBodySmallRegular(darkGrey)),
                    InkWell(
                      onTap: () => Get.to(
                        SettingChangePage(
                          title: 'Username',
                          hintText: controller.adminData['username'],
                          validator: (newValue) {
                            controller.updateAdminName(newValue ?? '');
                            return null;
                          },
                          onTap: () => controller.updateAdminNameData(),
                        ),
                      )!.then((value) {
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
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Email', style: tsBodySmallRegular(darkGrey)),
                    InkWell(
                      onTap: () async {
                        await Get.to(SettingChangePage(
                          title: 'Email',
                          hintText: controller.adminData['email'],
                          validator: (newValue) {
                            controller.updateEmail(newValue ?? '');
                            return null;
                          },
                          onTap: () => controller.updateEmailData(),
                        ))!.then((value) {
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
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nomor Telepon',
                        style: tsBodySmallRegular(darkGrey)),
                    InkWell(
                      onTap: () => Get.to(
                        SettingChangePage(
                          title: 'Nomor Telepon',
                          hintText: controller.adminData['phone'],
                          validator: (newValue) {
                            controller.updatePhoneNumber(newValue ?? '');
                            return null;
                          },
                          onTap: () =>
                              controller.updateAdminPhoneData(),
                        ),
                      )!.then((value) {
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
                ),
                SizedBox(height: 10),
                ContentTitleWidget(
                  title: "Pengaturan Tambahan",
                  lefttextSize: tsBodyMediumMedium(black),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Hapus akun',
                          style: tsBodySmallRegular(warningColor),
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () => controller
                            .showExitConfirmationDialog(context),
                        child: Text('Keluar akun',
                            style: tsBodySmallRegular(black)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MainProfileWidget extends GetView<SettingController> {
  const MainProfileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: grey,
          backgroundImage: NetworkImage(
            controller.adminData['image_path'] == null
                ? 'https://ui-avatars.com/api/?name=${controller.adminData['username']}&background=random&size=128'
                : 'https://pradiptaahmad.tech/image/${controller.adminData['image_path']}',
          ),
        ),
        SizedBox(height: 5),
        InkWell(
          onTap: () {
            controller.pickImage();
          },
          child: Text(
            "Ubah foto profil",
            style: tsBodySmallSemibold(successColor),
          ),
        ),
      ],
    );
  }
}
