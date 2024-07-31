import 'package:get/get.dart';
import '../models/ReviewModel.dart';

class ReviewPagecontroller extends GetxController {
  var selectedRating = 0.obs;
  var reviews = <Review>[
    Review(rating: 5, comment: "Excellent!", username: "User1"),
    Review(rating: 4, comment: "Very Good!", username: "User2"),
    Review(rating: 3, comment: "Good", username: "User3"),
    Review(rating: 2, comment: "Not bad", username: "User4"),
    Review(rating: 1, comment: "Needs improvement", username: "User5"),
  ].obs;

  List<Review> get filteredReviews {
    if (selectedRating.value == 0) {
      return reviews;
    } else {
      return reviews.where((review) => review.rating == selectedRating.value).toList();
    }
  }
}