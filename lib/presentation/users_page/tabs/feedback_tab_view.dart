import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:washit_admin/presentation/users_page/controllers/users_page.controller.dart';
import 'package:washit_admin/presentation/users_page/models/ReviewModel.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';
import '../../../infrastructure/theme/themes.dart';

class FeedbackTabView extends GetView<UsersPageController> {
  const FeedbackTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              children: [
                Padding(
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
                          SizedBox(height: 4),
                          Text(
                            controller.averageRating.value.toStringAsFixed(1),
                            style: tsBodyLargeSemibold(black),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.filter_list_rounded,
                        size: 20,
                        color: darkGrey,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    if (controller.reviews.isEmpty) {
                      return Center(child: Text("Tidak ada Review"));
                    }
                    return RefreshIndicator(
                      onRefresh: () async {
                        await controller.fetchRatingReviews();
                        await controller.fetchRatingSummary();
                      },
                      child: ListView.builder(
                        itemCount: controller.reviews.length,
                        itemBuilder: (context, index) {
                          var review = controller.reviews[index];
                          return _buildItemList(review);
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        }
      }),
    );
  }

  Widget _buildItemList(Review review) {
    return MainContainerWidget(
      margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 3),
      padding: EdgeInsets.all(15),
      childs: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  review.username,
                  style: tsBodyMediumMedium(black),
                ),
                SizedBox(height: 4),
                Text(
                  review.comment,
                  style: tsBodySmallRegular(darkGrey),
                ),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  Get.defaultDialog(
                    title: 'Konfirmasi',
                    middleText: 'Apakah Anda yakin ingin menghapus rating ini?',
                    confirm: ElevatedButton(
                      onPressed: () {
                        controller.deleteRating(review.id); // Ensure id is passed
                        Get.back(); // Close dialog
                      },
                      child: Text('Ya'),
                    ),
                    cancel: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text('Tidak'),
                    ),
                  );
                },
              ),
              SizedBox(width: 8),
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
        ],
      ),
    );
  }
}
