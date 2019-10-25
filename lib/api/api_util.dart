import 'package:connectivity/connectivity.dart';
import 'package:generalshop/exeptions/exeptions.dart';

class ApiUtil{
  static const String MAIN_API_URL = "http://192.168.153.1/generalshop/public/api/";
  static const String AUTH_REGISTER = MAIN_API_URL + 'auth/register';
  static const String AUTH_LOGIN = MAIN_API_URL + 'auth/login';
  static const String PRODUCTS = MAIN_API_URL + 'products';
  
  static const String PRODUCT = MAIN_API_URL + 'products/';
  static const String COUNTRIES = MAIN_API_URL + 'countries';
  static const String CATEGORIES = MAIN_API_URL + 'categories';
  static const String TAGS = MAIN_API_URL + 'tags';
  static const String CART = MAIN_API_URL + 'carts';

  static String CITIES(int id) { return MAIN_API_URL + 'countries/' + id.toString() + '/cities';}
  static String STATES(int id) { return MAIN_API_URL + 'countries/' + id.toString() + '/states';}
  static String CATEGORY_PRODUCTS(int id , int page) { return MAIN_API_URL + 'categories/' + id.toString() + '/products?page='+page.toString();}
}



Future<void> CheckInternet()async{
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
    throw NoInternetConnection();
  }
}