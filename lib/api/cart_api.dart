import 'dart:convert';
import 'package:generalshop/exeptions/exeptions.dart';
import 'package:http/http.dart' as http;
import 'api_util.dart';

class CartApi{

   Map<String,String> headers = {
      'Accept': 'application/json',
    };

Future<void> fetchcart()async{
await CheckInternet();
String url = ApiUtil.CART;
http.Response response = await http.get(url,headers: headers);
switch (response.statusCode) {
  case 200:
    var body = jsonDecode(response.body);
    
    break;
  default:
   throw ResourceNotFound('Categories');
   break;
}
}
}