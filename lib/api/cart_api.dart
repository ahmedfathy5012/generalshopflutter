import 'dart:convert';
import 'package:generalshop/cart/cart.dart';
import 'package:generalshop/exeptions/exeptions.dart';
import 'package:http/http.dart' as http;
import 'api_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartApi{

   Map<String,String> headers = {
      'Accept': 'application/json',
    };



Future<Cart> fetchcart()async{
await CheckInternet();
SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
String apiToken =  sharedPreferences.get('api_token');
print(apiToken);
    Map<String,String> authHeaders = {
      'Accept': 'application/json',
      'Authorization' : 'Bearer ' + apiToken ,
    };
String url = ApiUtil.CART;
http.Response response = await http.get(url,headers: authHeaders);
switch (response.statusCode) {
  case 200:
    var body = jsonDecode(response.body);
    return Cart.fromJson(body);
    break;
  default:
   throw ResourceNotFound('Cart');
   break;
  }
}


Future<bool> addProductToCart(int productID)async{
await CheckInternet();
SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
String apiToken =  sharedPreferences.get('api_token');
print(apiToken);
    Map<String,String> authHeaders = {
      'Accept': 'application/json',
      'Authorization' : 'Bearer ' + apiToken ,
    };

String url = ApiUtil.CART;
Map<String,dynamic> body = {
  'product_id' : productID.toString(),
  'qty'        : 1.00.toString(),
};
http.Response response = await http.post(url,headers: authHeaders , body: body);
   switch (response.statusCode) {
     case 200:
     case 201:
        return true;
        break;
     default:
        throw ResourceNotFound('Carts'); 
        break;
   }
}





}