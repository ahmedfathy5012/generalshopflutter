import 'dart:convert';

import 'product_unit.dart';
import 'product_category.dart';
import 'product_tag.dart';
import 'package:generalshop/review/product_reviews.dart';
import 'package:generalshop/exeptions/exeptions.dart';


class Product {
   int product_id;
   String product_title , product_description ;
  ProductUnit productUnit;
  double product_price , product_total , product_discount;
  ProductCategory productCategory;
  List<ProductTag> tags;
  List<String> images;
  List<ProductReviews> reviews ;
  

  Product(this.product_id,this.product_title,this.product_description,
          this.productUnit,this.product_price,this.product_total,
          this.product_discount,this.productCategory,
          this.tags,this.images,this.reviews);


  Product.fromJson(Map<String , dynamic> jsonObject){

    assert(jsonObject['product_id'] != null            , 'Product Id Is Null');
    assert(jsonObject['product_title'] != null         , 'Product Id Title Null');
    assert(jsonObject['product_description'] != null   , 'Product Id Description Null');
    assert(jsonObject['product_price'] != null         , 'Product Id Price Null');



               if(jsonObject['product_id'] == null)             throw PropertyIsRequired('Product ID');
               if(jsonObject['product_title'] == null)          throw PropertyIsRequired('Product Title');
               if(jsonObject['product_description'] == null)    throw PropertyIsRequired('Product Description');
               if(jsonObject['product_price'] == null)          throw PropertyIsRequired('Product Price');


          this.product_id = jsonObject['product_id'];
          this.product_title = jsonObject['product_title'];
          this.product_description = jsonObject['product_description'];
          this.productUnit = ProductUnit.fromJson(jsonObject['product_unit']);
          this.product_price = double.tryParse(jsonObject['product_price']);
          this.product_total = double.tryParse(jsonObject['product_total']);
          this.product_discount = double.tryParse(jsonObject['product_discount']);
          this.productCategory = ProductCategory.fromJson(jsonObject['product_category']);

          this.tags = [];
          if(jsonObject['product_tags'] !=null){
             _setTags(jsonObject['product_tags']);
          }else{}
          
          
          this.images = [] ;
          if(jsonObject['product_images'] != null){
            _setImages(jsonObject['product_images']);
          }else{}
          
          this.reviews = [];
          if(jsonObject['product_reviews'] != null){
              _setReviews(jsonObject['product_reviews']);
          }else{}
         

  }
  

  void _setReviews(List<dynamic> reviewsJson){
       
       if(reviewsJson.length>0){
            for(var item in reviewsJson){
              if(item != null){
                  reviews.add(ProductReviews.fromJson(item));
              }        
         }
       }

  }


  void _setTags(List<dynamic> tagsJson){
      
      if(tagsJson.length>0){
         for(var item in tagsJson){
            if(item!=null){
               tags.add(ProductTag.fromJson(item));
            }            
          } 
      }
          
  }


  void _setImages(List<dynamic> jsonImages){
    
    if(jsonImages.length>0){
     for(var image in jsonImages){
       if(image!=null){
         images.add(image['image_url']);
       }      
     }
    }   
  }

  String featuredImage(){
     if(this.images.length>0){
      return this.images[0];
      // return 'https://images.pexels.com/photos/414612/pexels-photo-414612.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
     }
        return 'https://cdn.pixabay.com/photo/2018/02/09/21/46/rose-3142529__340.jpg';
     
  }
}