import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/widget/auth/input_form_widget.dart';
import 'package:washit_admin/widget/common/mainpage_appbar_widget.dart';

import '../../infrastructure/theme/themes.dart';
import 'controllers/add_notification_page.controller.dart';

class AddNotificationPage extends GetView<AddNotificationPageController> {
  const AddNotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainpageAppbarWidget(
        title: "Siarkan Notifikasi",
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Column(
            children: [
              InputFormWidget(
                title: "Judul Notifikasi",
                hintText: "Masukkan Judul Notifikasi",
              ),
              InputFormWidget(
                title: "Deskripsi",
                hintText: "Masukkan Deskripsi Notifikasi",
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(15),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Kirim Notifikasi",
                    style: tsBodySmallMedium(primaryColor),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
