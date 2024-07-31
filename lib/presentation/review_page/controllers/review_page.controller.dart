import 'package:get/get.dart';
import 'package:washit_admin/presentation/review_page/models/ReviewModel.dart';

class ReviewPageController extends GetxController {
  var selectedRating = 0.obs;
  var reviews = <Review>[
    Review(rating: 5, comment: "Excellent!", username: "User A"),
    Review(rating: 4, comment: "Very Good!", username: "User B"),
    Review(rating: 3, comment: "Good", username: "User C"),
    Review(rating: 2, comment: "Not bad", username: "User D"),
    Review(rating: 1, comment: "Needs improvement", username: "User E"),
  ].obs;

  List<Review> get filteredReviews {
    if (selectedRating.value == 0) {
      return reviews;
    } else {
      return reviews.where((review) => review.rating == selectedRating.value).toList();
    }
  }
}