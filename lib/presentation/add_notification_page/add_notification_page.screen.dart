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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Judul Notifikasi tidak boleh kosong";
                  } else {
                    controller.judul.value = value;
                  }
                  return null;
                },
              ),
              InputFormWidget(
                title: "Deskripsi",
                hintText: "Masukkan Deskripsi Notifikasi",
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi Notifikasi tidak boleh kosong";
                  } else {
                    controller.deskripsi.value = value;
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () => controller.postNotification(),
                child: Container(
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
                ),
              )
            ],
          )),
    );
  }
}
