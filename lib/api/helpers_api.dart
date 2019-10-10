import 'dart:developer';


import 'package:generalshop/utility/country.dart';
import 'package:generalshop/product/product_category.dart';
import 'package:generalshop/product/product_tag.dart';
import 'package:generalshop/utility/country_city.dart';
import 'package:generalshop/utility/country_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_util.dart';


class HelpersApi{
   
   Map<String,String> headers = {
      'Accept': 'application/json',
    };


  Future<List<ProductCategory>> fetchCategory(int page)async{
      String url = ApiUtil.CATEGORIES + '?page=' + page.toString() ;
      http.Response response = await http.get(url ,headers:headers);
      List<ProductCategory> categories = [];
      if(response.statusCode==200){
         var body = jsonDecode(response.body);
         for(var item in body['data']){
             categories.add(
               ProductCategory.fromJson(item)
             );
         }
      }
      return categories;
   }


  Future<List<ProductTag>> fetchTags(int page)async{
      String url = ApiUtil.TAGS + '?page=' + page.toString();
      http.Response response = await http.get(url ,headers:headers);
      List<ProductTag> tags = [];
      if(response.statusCode==200){
           var body = jsonDecode(response.body);
         for(var item in body['data']){
             tags.add(
               ProductTag.fromJson(item)
             );
         }
      }
      return tags;
   }


  Future<List<Country>> fetchCountries(int page)async{ 
      String url = ApiUtil.COUNTRIES + '?page=' + page.toString();
      http.Response response = await http.get(url ,headers:headers);
      List<Country> countries = [];
      if(response.statusCode==200){
          var body = jsonDecode(response.body);
         for(var item in body['data']){
             countries.add(
               Country.fromJson(item)
             );
         }
      }
      return countries;
   }


  Future<List<CountryCity>> fetchCities(int country ,int page)async{
      String url = ApiUtil.CITIES(country) + '?page=' + page.toString();
      http.Response response = await http.get(url ,headers:headers);
      List<CountryCity> cities = [];
      if(response.statusCode==200){
          var body = jsonDecode(response.body);
         for(var item in body['data']){
             cities.add(
               CountryCity.fromJson(item)
             );
         }
      }
      return cities;
   }
  

  Future<List<CountryState>> fetchStates(int country , int page)async{
        String url = ApiUtil.STATES(country) + '?page=' + page.toString();
        http.Response response = await http.get(url ,headers:headers);
        List<CountryState> states = [];
        if(response.statusCode==200){
          var body = jsonDecode(response.body);
         for(var item in body['data']){
             states.add(
               CountryState.fromJson(item)
             );
         }
        }
        return states;
   }

}