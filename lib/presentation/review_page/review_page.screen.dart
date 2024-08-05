import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/presentation/review_page/controllers/review_page.controller.dart';
import 'package:washit_admin/infrastructure/theme/themes.dart';

class ReviewPageScreen extends StatelessWidget {
  final ReviewPageController controller = Get.put(ReviewPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Column(
          children: [
            Obx(() {
              double averageRating = controller.reviews.fold(0, (sum, item) => sum + item.rating) / controller.reviews.length;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Average Rating",
                          style: tsBodySmallMedium(darkGrey),
                        ),
                        SizedBox(height: 1),
                        Text(
                          averageRating.toStringAsFixed(1),
                          style: tsHeadlineSmallBold(black),
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: DropdownButton<int>(
                        value: controller.selectedRating.value,
                        items: [
                          DropdownMenuItem(
                              child: Text(
                                "All",
                                style: tsBodyMediumMedium(black),
                              ),
                              value: 0
                          ),
                          DropdownMenuItem(child: Text("5 Stars", style: tsBodyMediumRegular(black)), value: 5),
                          DropdownMenuItem(child: Text("4 Stars", style: tsBodyMediumRegular(black)), value: 4),
                          DropdownMenuItem(child: Text("3 Stars", style: tsBodyMediumRegular(black)), value: 3),
                          DropdownMenuItem(child: Text("2 Stars", style: tsBodyMediumRegular(black)), value: 2),
                          DropdownMenuItem(child: Text("1 Star", style: tsBodyMediumRegular(black)), value: 1),
                        ],
                        onChanged: (value) {
                          controller.selectedRating.value = value!;
                        },
                        underline: SizedBox(),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.filteredReviews.length,
                  itemBuilder: (context, index) {
                    var review = controller.filteredReviews[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 9), // Margin kanan kiri diubah jadi 15
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/images/user_profile.png'),
                            radius: 26,
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      review.username,
                                      style: tsBodyMediumMedium(black),
                                    ),
                                    Row(
                                      children: List.generate(5, (starIndex) {
                                        return Icon(
                                          starIndex < review.rating ? Icons.star : Icons.star_border,
                                          color: Colors.amber,
                                          size: MediaQuery.of(context).size.width * 0.04,
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  review.comment,
                                  style: tsBodySmallRegular(darkGrey),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
