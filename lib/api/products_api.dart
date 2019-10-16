import 'package:generalshop/exeptions/exeptions.dart';

import 'api_util.dart';
import 'package:generalshop/product/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ProductApi{

   Map<String,String> headers = {
      'Accept': 'application/json',
    };

  Future<List<Product>> fetchProducts(int page) async{
    await CheckInternet();
     String url = ApiUtil.PRODUCTS + '?page=' + page.toString() ; 
     http.Response response = await http.get(url, headers: headers);
     
     List<Product> products = [];
     if(response.statusCode == 200){
        var body = jsonDecode(response.body);
        for (var item in body['data']){          
          products.add(
            Product.fromJson(item)
          );
        }
        return products;
     }
     return null;
  }

  Future<List<Product>> fetchProductsByCategory(int category , int page) async{
    await CheckInternet();
     String url = ApiUtil.CATEGORY_PRODUCTS(category,page) ; 
     http.Response response = await http.get(url, headers: headers);
     
       List<Product> products = [];
     switch (response.statusCode) {
          case 200:              
        var body = jsonDecode(response.body);
        for (var item in body['data']){          
          products.add(
            Product.fromJson(item)
          );
        }       
            return products;
            break;

          case 404:
             throw ResourceNotFound('Products');
            break;

          case 301:
          case 302:
          case 303:
            throw RedirectionFound();
            break;

          default:
            return null;
            break;
        }
     }
    
  


  Future<Product> fetchProduct(int product_id)async{
    await CheckInternet();
    String url = ApiUtil.PRODUCT + product_id.toString();
    http.Response response = await http.get(url, headers: headers);
    if(response.statusCode==200){
      var body = jsonDecode(response.body);     
      return Product.fromJson(body['data']);
    }
    return null;
  }
}