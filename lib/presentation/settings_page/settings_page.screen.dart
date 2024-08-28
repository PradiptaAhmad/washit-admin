import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/settings_page/controllers/settings_page.controller.dart';
import 'package:washit_admin/widget/common/content_title_widget.dart';
import '../../infrastructure/navigation/routes.dart';

class SettingPage extends GetView<SettingController> {
  SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.fetchUserData();
            controller.updatePhotoProfile();
          },
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(defaultMargin),
            child: Column(
              children: [
                ContentTitleWidget(
                  title: "Profil Saya",
                  lefttextSize: tsTitleSmallMedium(black),
                ),
                SizedBox(height: 10),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return MainProfileWidget();
                  }
                }),
                SizedBox(height: 5),
                Divider(color: lightGrey, thickness: 1),
                ContentTitleWidget(
                  title: "Info Profil",
                  lefttextSize: tsBodyMediumMedium(black),
                ),
                SizedBox(height: 20),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Username',
                                style: tsBodySmallRegular(darkGrey)),
                            Row(
                              children: [
                                Text('${controller.userData['username']}',
                                    overflow: TextOverflow.ellipsis,
                                    style: tsBodySmallRegular(black)),
                                SizedBox(width: 20),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: darkGrey,
                                  size: 15,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Email', style: tsBodySmallRegular(darkGrey)),
                            Row(
                              children: [
                                Text('${controller.userData['email']}',
                                    style: tsBodySmallRegular(black)),
                                SizedBox(width: 20),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: darkGrey,
                                  size: 15,
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Nomor Hp',
                                style: tsBodySmallRegular(darkGrey)),
                            Row(
                              children: [
                                Text('${controller.userData['phone']}',
                                    style: tsBodySmallRegular(black)),
                                SizedBox(width: 20),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: darkGrey,
                                  size: 15,
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    );
                  }
                }),
                SizedBox(height: 10),
                ContentTitleWidget(
                  title: "Info Profil",
                  lefttextSize: tsBodyMediumMedium(black),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      InkWell(
                        onTap: () =>
                            controller.showExitConfirmationDialog(context),
                        child: Text('Keluar akun',
                            style: tsBodySmallRegular(warningColor)),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.FITUR_PAGE);
                        },
                        child: Text('Edit Fitur'),
                      ),
                    ],
                  ),
                )
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
          backgroundImage: NetworkImage(controller.userData['image_path'] ==
              null
              ? 'https://ui-avatars.com/api/?name=${controller.userData['username']}&background=random&size=128'
              : 'https://pradiptaahmad.tech/image/${controller.userData['image_path']}'),
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