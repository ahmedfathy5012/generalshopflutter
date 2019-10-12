import 'reviewer.dart';
import 'package:generalshop/exeptions/exeptions.dart';

class ProductReviews{
  int review_id , review_star ;
  String review;
  Reviewer reviewer;


  ProductReviews(this.review_id,this.review_star,this.review,this.reviewer);

  ProductReviews.fromJson(Map<String , dynamic> jsonObject){

    assert(jsonObject['review_id'] != null      , 'Review Id Is Null');
    assert(jsonObject['stars'] != null          , 'Stars Is Null');
    assert(jsonObject['review'] != null         , 'Review Is Null');
    assert(jsonObject['reviewer'] != null       , 'Reviewer Is Null');

    if(jsonObject['review_id'] == null )          throw    PropertyIsRequired('Review Id');
    if(jsonObject['stars'] == null )              throw    PropertyIsRequired('Stars');
    if(jsonObject['review'] == null )             throw    PropertyIsRequired('Review');
    if(jsonObject['reviewer'] == null )           throw    PropertyIsRequired('Reviewer');

    this.review_id = jsonObject['review_id'];
    this.review_star = jsonObject['stars'];
    this.review = jsonObject['review'];
    this.reviewer = Reviewer.fromJson(jsonObject ['reviewer']);

  }
}