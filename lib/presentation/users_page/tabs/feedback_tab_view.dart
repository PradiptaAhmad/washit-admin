import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/presentation/users_page/controllers/users_page.controller.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';

import '../../../infrastructure/theme/themes.dart';

class FeedbackTabView extends GetView<UsersPageController> {
  const FeedbackTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Obx(() {
              double averageRating =
                  controller.reviews.fold(0, (sum, item) => sum + item.rating) /
                      controller.reviews.length;
              return Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rata-rata Penilaian",
                          style: tsLabelLargeMedium(darkGrey),
                        ),
                        SizedBox(height: 1),
                        Text(
                          averageRating.toStringAsFixed(1),
                          style: tsBodyLargeSemibold(black),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.filter_list_rounded,
                        size: 20,
                        color: darkGrey,
                      ),
                    )
                  ],
                ),
              );
            }),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: controller.filteredReviews.length,
                itemBuilder: (context, index) {
                  var review = controller.filteredReviews[index];
                  return _buildItemList(review);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

Widget _buildItemList(review) {
  return MainContainerWidget(
    margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 3),
    padding: EdgeInsets.all(15),
    childs: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              review.username,
              style: tsBodyMediumMedium(black),
            ),
            Text(
              review.comment,
              style: tsBodySmallRegular(darkGrey),
            ),
          ],
        ),
        Row(
          children: List.generate(5, (starIndex) {
            return Icon(
              starIndex < review.rating ? Icons.star : Icons.star_border,
              color: Colors.amber,
              size: 20,
            );
          }),
        ),
      ],
    ),
  );
}
