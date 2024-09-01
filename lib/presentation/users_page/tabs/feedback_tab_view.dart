import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:washit_admin/presentation/users_page/controllers/users_page.controller.dart';
import 'package:washit_admin/widget/common/main_container_widget.dart';

import '../../../infrastructure/theme/themes.dart';

class FeedbackTabView extends GetView<UsersPageController> {
  const FeedbackTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.averageRating.value.toStringAsFixed(1),
                          style: tsTitleLargeMedium(black),
                        ),
                        RatingBarIndicator(
                          itemSize: 15,
                          unratedColor: lightGrey,
                          itemBuilder: (context, index) {
                            return Icon(
                              Icons.star,
                              color: Colors.amber,
                            );
                          },
                          rating: controller.averageRating.value.toDouble(),
                        ),
                        Text(
                          "${controller.totalReviews.value} Ulasan",
                          style: tsLabelLargeMedium(grey),
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
              Obx(() {
                if (controller.reviews.isEmpty) {
                  return Center(child: Text("Tidak ada Review"));
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchRatingReviews();
                    await controller.fetchRatingSummary();
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.reviews.length,
                    itemBuilder: (context, index) {
                      var review = controller.reviews[index];
                      return _buildItemList(review);
                    },
                  ),
                );
              }),
            ],
          ),
        );
      }
    });
  }

  Widget _buildItemList(review) {
    return MainContainerWidget(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      padding: EdgeInsets.all(15),
      childs: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: grey,
                    backgroundImage: NetworkImage(
                      review['user']['image_path'] == null
                          ? 'https://ui-avatars.com/api/?name=${review['user']['username']}&background=random&size=128'
                          : 'https://pradiptaahmad.tech/image/${review['user']['image_path']}',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${review['user']['username']}",
                      style: tsLabelLargeMedium(black),
                    ),
                    Text(
                      "Bergabung ${DateFormat('d MMMM yyyy', 'id_ID').format(DateTime.parse(review['user']['created_at']))}",
                      style: tsLabelLargeMedium(grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          RatingBarIndicator(
            itemSize: 15,
            unratedColor: lightGrey,
            itemBuilder: (context, index) {
              return Icon(
                Icons.star,
                color: Colors.amber,
              );
            },
            rating: review['rating'].toDouble(),
          ),
          SizedBox(height: 5),
          Text(
            "${review['review']}",
            style: tsLabelLargeMedium(darkGrey),
          ),
        ],
      ),
    );
  }
}
