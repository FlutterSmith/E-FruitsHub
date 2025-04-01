import 'package:fruits_hub/core/entites/review_entity.dart';

num getAverageRating(List<ReviewEntity> reviews) {
  var totalRating = 0.0;
  for (var review in reviews) {
    totalRating += review.ratting;
  }
  return totalRating / reviews.length;
}
