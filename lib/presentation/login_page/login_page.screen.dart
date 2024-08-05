import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/themes.dart';
import '../../widget/common/auth_text_field.dart';
import '../../widget/common/button_widget.dart';
import 'controllers/login_page.controller.dart';

class LoginPageScreen extends GetView<LoginPageController> {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Container(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.1,
            ),
            Text(
              "Login",
              style: tsHeadlineMediumSemibold(black),
            ),
            Text(
              "Masukkan Email Dan Password",
              style: tsBodyMediumRegular(darkGrey),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Email",
              style: tsBodyMediumMedium(black),
            ),
            SizedBox(
              height: 12,
            ),
            AuthTextField(
              hintText: "Masukkan Email",
              validator: (value) {
                final emailRegex = RegExp(
                  r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                );
                if (value == null || value.isEmpty) {
                  return "Email tidak boleh kosong";
                } else if (!emailRegex.hasMatch(value)) {
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
              "Password",
              style: tsBodyMediumMedium(black),
            ),
            SizedBox(
              height: 12,
            ),
            Obx(() => AuthTextField(
                  hintText: "Masukkan Password",
                  onChanged: (value) {},
                  isObsecure: controller.isObsecure.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password tidak boleh kosong";
                    } else {
                      controller.password.value = value;
                      return null;
                    }
                  },
                  suffixIcon: IconButton(
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
                  ),
                )),
            Container(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {},
                child: Text(
                  "Lupa Password?",
                  style: tsLabelLargeMedium(darkBlue),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() => ButtonWidget(
                  backgroundColor: secondaryColor,
                  child: controller.isLoading.value
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Transform.scale(
                            scale: 0.5,
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            "Login",
                            style: tsBodySmallSemibold(primaryColor),
                          ),
                        ),
                  onPressed: () {
                    controller.login();
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
                  height: 20,
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
                        "Login Dengan Google",
                        style: tsBodySmallSemibold(darkBlue),
                      ),
                      Spacer(),
                    ],
                  ),
                )),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Belum punya akun?",
                  style: tsBodySmallMedium(darkGrey),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "Daftar Sekarang",
                    style: tsBodySmallBold(darkBlue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
