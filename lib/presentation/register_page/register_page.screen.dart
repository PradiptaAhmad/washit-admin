import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/themes.dart';
import '../../widget/common/auth_text_field.dart';
import '../../widget/common/button_widget.dart';
import 'controllers/register_page.controller.dart';

class RegisterPageScreen extends GetView<RegisterPageController> {
  const RegisterPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Text(
                "Daftar",
                style: tsHeadlineMediumSemibold(black),
              ),
              Text(
                "Masukkan Data Diri Kamu Dibawah Ini",
                style: tsBodyMediumRegular(darkGrey),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Username",
                style: tsBodySmallMedium(black),
              ),
              SizedBox(
                height: 12,
              ),
              AuthTextField(
                hintText: "Masukkan Username",
                // onChanged: controller.username,

                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Username tidak boleh kosong";
                  } else {
                    controller.username.value = value;
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Email",
                style: tsBodySmallMedium(black),
              ),
              SizedBox(
                height: 12,
              ),
              AuthTextField(
                hintText: "Masukkan Email",
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email tidak boleh kosong";
                  } else if (!GetUtils.isEmail(value)) {
                    return "Email tidak valid";
                  } else {
                    controller.email.value = value;
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Nomor Telepon",
                style: tsBodySmallMedium(black),
              ),
              SizedBox(
                height: 12,
              ),
              AuthTextField(
                hintText: "Masukkan Nomor Telepon",
                keyboardType: TextInputType.phone,
                formatter: [
                  LengthLimitingTextInputFormatter(14),
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nomor Telepon tidak boleh kosong";
                  } else {
                    controller.phone.value = value;
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Password",
                style: tsBodySmallMedium(black),
              ),
              SizedBox(
                height: 12,
              ),
              Obx(() => AuthTextField(
                    hintText: "Masukkan Password",
                    isObsecure: controller.isObsecure.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Username tidak boleh kosong";
                      } else {
                        controller.password.value = value;
                        return null;
                      }
                    },
                    suffixIcon: Obx(() => IconButton(
                          onPressed: () {
                            controller.isObsecure.value =
                                !controller.isObsecure.value;
                          },
                          icon: Icon(
                            controller.isObsecure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 22,
                          ),
                        )),
                  )),
              SizedBox(
                height: 20,
              ),
              Obx(() => ButtonWidget(
                    child: controller.isLoading.value
                        ? Container(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Transform.scale(
                              scale: 0.4,
                              child: CircularProgressIndicator(
                                color: primaryColor,
                                strokeWidth: 5,
                              ),
                            ),
                          )
                        : Container(
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              "Daftar Akun Baru",
                              style: tsBodySmallSemibold(primaryColor),
                            ),
                          ),
                    backgroundColor: secondaryColor,
                    onPressed: () {
                      controller.register();
                    },
                  )),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: lightGrey,
                    width: screenWidth * 0.39,
                    height: 2,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Atau",
                    style: tsBodySmallMedium(darkGrey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    color: lightGrey,
                    width: screenWidth * 0.39,
                    height: 2,
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: lightGrey, width: 2),
                    ),
                  ),
                  child: Container(
                    height: 25,
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // SvgPicture.asset(
                        //   "assets/icons/icGoogle.svg",
                        //   width: 25,
                        // ),
                        Spacer(),
                        Text(
                          "Daftar Dengan Google",
                          style: tsBodySmallSemibold(darkBlue),
                        ),
                        Spacer(),
                      ],
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah punya akun?",
                    style: tsBodySmallMedium(darkGrey),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "Masuk Sekarang",
                      style: tsBodySmallBold(darkBlue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
