import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:washit_admin/presentation/settings_page/controllers/settings_page.controller.dart';

import '../../infrastructure/theme/themes.dart';
import '../../widget/auth/input_form_widget.dart';

class SettingChangePage extends GetView<SettingController> {
  const SettingChangePage({
    Key? key,
    this.title,
    this.validator,
    this.onTap,
    this.hintText,
  }) : super(key: key);

  final String? title;
  final validator;
  final hintText;
  final onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: primaryColor,
        title: Text("Ubah $title", style: tsBodyLargeMedium(black)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
        child: Column(
          children: [
            InputFormWidget(
              title: "$title",
              hintText: hintText,
              validator: validator,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: onTap,
                child: Obx(() => controller.isLoading.value
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Transform.scale(
                          scale: 0.4,
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "Konfirmasi",
                          style: tsBodyMediumRegular(primaryColor),
                        ),
                      )),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
