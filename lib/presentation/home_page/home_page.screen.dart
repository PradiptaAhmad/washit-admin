import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';
import 'package:washit_admin/presentation/home_page/detail_mainwidget_page.dart';

import 'controllers/home_page.controller.dart';

class HomePageScreen extends GetView<HomePageController> {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(defaultMargin),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 45,
                      width: 100,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    height: 50,
                    width: 50,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Get.to(() => DetailMainwidgetPage());
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1.5,
                        blurRadius: 2,
                        offset: Offset(0.5, 2), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 150,
                  width: double.infinity,
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "No. Transaksi - 00414519797419",
                          style: tsLabelLargeRegular(darkGrey),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              height: 60,
                              width: 60,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Cuci Setrika - Bawwaz",
                                  style: tsBodySmallSemibold(black),
                                ),
                                Text(
                                  "Berat - 5Kg",
                                  style: tsLabelLargeSemibold(darkGrey),
                                ),
                                Text(
                                  "Rp. 25.000",
                                  style: tsLabelLargeBold(successColor),
                                )
                              ],
                            )
                          ],
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "23 Maret 2024",
                                style: tsLabelLargeRegular(black),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: successColor,
                                ),
                                height: 30,
                                width: 80,
                                child: Expanded(
                                  child: Center(
                                    child: Text(
                                      "on Progress",
                                      style: tsLabelLargeSemibold(primaryColor),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
