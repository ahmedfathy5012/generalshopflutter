import 'dart:developer';


import 'package:generalshop/exeptions/redirection_found.dart';
import 'package:generalshop/exeptions/resource_not_found.dart';
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
      switch (response.statusCode) {
        case 200:
          var body = jsonDecode(response.body);
          for(var item in body['data']){
            categories.add(
                ProductCategory.fromJson(item)
            );
          }
          return categories;
          break;

        case 404:
          throw ResourceNotFound();
          break;


        case 301:
        case 302:
        case 303:
          throw RedirectionFound();
          break;



        default:
      }


   }


  Future<List<ProductTag>> fetchTags(int page)async{
      String url = ApiUtil.TAGS + '?page=' + page.toString();
      http.Response response = await http.get(url ,headers:headers);
      List<ProductTag> tags = [];
      switch (response.statusCode) {
        case 200:
          var body = jsonDecode(response.body);
          for(var item in body['data']){
            tags.add(
                ProductTag.fromJson(item)
            );
          }
          return tags;
          break;

        case 404:
          throw ResourceNotFound();
          break;


        case 301:
        case 302:
        case 303:
          throw RedirectionFound();
          break;



        default:
      }


   }


  Future<List<Country>> fetchCountries(int page)async{ 
      String url = ApiUtil.COUNTRIES + '?page=' + page.toString();
      http.Response response = await http.get(url ,headers:headers);
      List<Country> countries = [];
      switch (response.statusCode) {
        case 200:
          var body = jsonDecode(response.body);
          for(var item in body['data']){
            countries.add(
                Country.fromJson(item)
            );
          }
          return countries;
          break;

        case 404:
          throw ResourceNotFound();
          break;


        case 301:
        case 302:
        case 303:
          throw RedirectionFound();
          break;



        default:
      }


   }


  Future<List<CountryCity>> fetchCities(int country ,int page)async{
      String url = ApiUtil.CITIES(country) + '?page=' + page.toString();
      http.Response response = await http.get(url ,headers:headers);
      List<CountryCity> cities = [];
      switch (response.statusCode) {
        case 200:
          var body = jsonDecode(response.body);
           for(var item in body['data']){
             cities.add(
               CountryCity.fromJson(item)
             );
         }
         return cities;
          break;
        case 404:
          return throw ResourceNotFound();
          break;

        case 301:
        case 302:
        case 303:
          throw RedirectionFound();
          break;


        default:
      }
     
      return null;
   }
  

  Future<List<CountryState>> fetchStates(int country , int page)async{
        String url = ApiUtil.STATES(country) + '?page=' + page.toString();
        http.Response response = await http.get(url ,headers:headers);
        List<CountryState> states = [];
        switch (response.statusCode) {
          case 200:
          var body = jsonDecode(response.body);
          for(var item in body['data']){
             states.add(
              CountryState.fromJson(item)
             );
         }
          return states;
            break;

          case 404:
             throw ResourceNotFound();
            break;


          case 301:
          case 302:
          case 303:
            throw RedirectionFound();
            break;



          default:
        }

        return null;
   }

}