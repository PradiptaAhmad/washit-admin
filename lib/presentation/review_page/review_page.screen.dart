import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/presentation/review_page/controllers/review_page.controller.dart';
import 'package:washit_admin/presentation/review_page/models/ReviewModel.dart';

class ReviewPageScreen extends StatelessWidget {
  final ReviewPageController controller = Get.put(ReviewPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
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
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(height: 1),
                        Text(
                          averageRating.toStringAsFixed(1),
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    DropdownButton<int>(
                      value: controller.selectedRating.value,
                      items: [
                        DropdownMenuItem(child: Text("All"), value: 0),
                        DropdownMenuItem(child: Text("5 Stars"), value: 5),
                        DropdownMenuItem(child: Text("4 Stars"), value: 4),
                        DropdownMenuItem(child: Text("3 Stars"), value: 3),
                        DropdownMenuItem(child: Text("2 Stars"), value: 2),
                        DropdownMenuItem(child: Text("1 Star"), value: 1),
                      ],
                      onChanged: (value) {
                        controller.selectedRating.value = value!;
                      },
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
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 9),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 25),
                            padding: EdgeInsets.only(top: 12, bottom: 12, left: 40, right: 16),
                            decoration: BoxDecoration(
                              color: Color(0xFFF9F9F9),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      review.username,
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(width: 8),
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
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: -3,
                            top: 7,
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/images/user_profile.png'),
                              radius: 26,
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