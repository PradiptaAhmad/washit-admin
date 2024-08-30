import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/themes.dart';
import '../../widget/auth/auth_text_field.dart';
import '../../widget/auth/input_form_widget.dart';
import '../../widget/common/button_widget.dart';
import 'controllers/login_page.controller.dart';

class LoginPageScreen extends GetView<LoginPageController> {
  const LoginPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight(context) * 0.1,
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
                height: 35,
              ),
              InputFormWidget(
                title: "Email",
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
              InputFormWidget(
                title: "Password",
                hintText: "Masukkan Password",
                textField: Obx(() => AuthTextField(
                      hintText: "Masukkan Password",
                      onChanged: (value) {
                        controller.password.value = value;
                      },
                      isObsecure: controller.isObsecure.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.isObsecure.value =
                              !controller.isObsecure.value;
                        },
                        icon: Icon(
                          controller.isObsecure.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 20,
                          color: darkGrey,
                        ),
                      ),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(top: 5),
                alignment: Alignment.topRight,
                child: InkWell(
                  // onTap: () => controller.forgotPassword(),
                  child: Text(
                    "Lupa Password?",
                    style: tsLabelLargeSemibold(darkBlue),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Obx(() => ButtonWidget(
                    backgroundColor: secondaryColor,
                    child: controller.isLoading.value
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Transform.scale(
                              scale: 0.5,
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              "Login",
                              style: tsBodySmallSemibold(primaryColor),
                            ),
                          ),
                    onPressed: () {
                      controller.login();
                    },
                  )),
              // DividerWidget(screenWidth: screenWidth),
              SizedBox(height: 15),
              ButtonWidget(
                onPressed: () {
                  // controller.signInWithGoogle();
                },
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: primaryColor,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //     side: BorderSide(color: lightGrey, width: 2),
                //   ),
                // ),
                child: Padding(
                  padding: const EdgeInsets.all(defaultMargin),
                  child: Row(
                    children: [
                      // SvgPicture.asset(
                      //   "assets/icons/icGoogle.svg",
                      //   width: 20,
                      // ),
                      Spacer(),
                      Text(
                        "Login Dengan Google",
                        style: tsBodySmallSemibold(darkBlue),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text(
              //         "Belum punya akun?",
              //         style: tsBodySmallMedium(darkGrey),
              //       ),
              //       SizedBox(width: 5),
              //       InkWell(
              //         onTap: () {
              //           Get.toNamed(Routes.REGISTER_PAGE);
              //         },
              //         borderRadius: BorderRadius.circular(5),
              //         child: Text(
              //           "Daftar Sekarang",
              //           style: tsBodySmallBold(darkBlue),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    ));
  }
}
