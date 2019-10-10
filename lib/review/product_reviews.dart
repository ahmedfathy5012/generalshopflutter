import 'reviewer.dart';

class ProductReviews{
  int review_id , review_star ;
  String review;
  Reviewer reviewer;


  ProductReviews(this.review_id,this.review_star,this.review,this.reviewer);

  ProductReviews.fromJson(Map<String , dynamic> jsonObject){
    this.review_id = jsonObject['review_id'];
    this.review_star = jsonObject['review_star'];
    this.review = jsonObject['review'];
    this.reviewer = Reviewer.fromJson(jsonObject ['reviewer']);

  }
}