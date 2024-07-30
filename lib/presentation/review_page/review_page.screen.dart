import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/review_page.controller.dart';

class ReviewPagescreen extends StatelessWidget {
  final ReviewPagecontroller controller = Get.put(ReviewPagecontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                double averageRating = controller.reviews.fold(0, (sum, item) => sum + item.rating) / controller.reviews.length;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Average Rating: ${averageRating.toStringAsFixed(1)}",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < averageRating ? Icons.star : Icons.star_border,
                              color: Colors.amber,
                              size: MediaQuery.of(context).size.width * 0.06,
                            );
                          }),
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
                      style: TextStyle(color: Colors.black),
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              }),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount: controller.filteredReviews.length,
                  itemBuilder: (context, index) {
                    var review = controller.filteredReviews[index];
                    return Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: List.generate(5, (starIndex) {
                                return Icon(
                                  starIndex < review.rating ? Icons.star : Icons.star_border,
                                  color: Colors.amber,
                                  size: MediaQuery.of(context).size.width * 0.06,
                                );
                              }),
                            ),
                            SizedBox(height: 8),
                            Text(
                              review.username, // Display username
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 4),
                            Text(
                              review.comment,
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
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