import 'dart:developer';


import 'package:generalshop/exeptions/exeptions.dart';
import 'package:generalshop/utility/country.dart';
import 'package:generalshop/product/product_category.dart';
import 'package:generalshop/product/product_tag.dart';
import 'package:generalshop/utility/country_city.dart';
import 'package:generalshop/utility/country_state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_util.dart';
import 'package:connectivity/connectivity.dart';

class HelpersApi{
   
   Map<String,String> headers = {
      'Accept': 'application/json',
    };


  Future<List<ProductCategory>> fetchCategories()async{
    await CheckInternet();
      String url = ApiUtil.CATEGORIES;
      http.Response response = await http.get(url ,headers:headers);

      switch (response.statusCode) {
        case 200:
          List<ProductCategory> categories = [];
          var body = jsonDecode(response.body);
          for(var item in body['data']){
           // print(item);
            categories.add(
                ProductCategory.fromJson(item)
            );
          }
          return categories;
          break;

        case 404:
          throw ResourceNotFound('Categories');
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


  Future<List<ProductTag>> fetchTags(int page)async{
    await CheckInternet();
      String url = ApiUtil.TAGS + '?page=' + page.toString();
      http.Response response = await http.get(url ,headers:headers);

      switch (response.statusCode) {
        case 200:
          List<ProductTag> tags = [];
          var body = jsonDecode(response.body);
          for(var item in body['data']){
            tags.add(
                ProductTag.fromJson(item)
            );
          }
          return tags;
          break;

        case 404:
          throw ResourceNotFound('Tags');
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


  Future<List<Country>> fetchCountries(int page)async{
    await CheckInternet();
      String url = ApiUtil.COUNTRIES + '?page=' + page.toString();
      http.Response response = await http.get(url ,headers:headers);

      switch (response.statusCode) {
        case 200:
          List<Country> countries = [];
          var body = jsonDecode(response.body);
          for(var item in body['data']){
            countries.add(
                Country.fromJson(item)
            );
          }
          return countries;
          break;

        case 404:
          throw ResourceNotFound('Countries');
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


  Future<List<CountryCity>> fetchCities(int country ,int page)async{
      String url = ApiUtil.CITIES(country) + '?page=' + page.toString();
      http.Response response = await http.get(url ,headers:headers);
      await CheckInternet();
      switch (response.statusCode) {
        case 200:
          List<CountryCity> cities = [];
          var body = jsonDecode(response.body);
           for(var item in body['data']){
             cities.add(
               CountryCity.fromJson(item)
             );
         }
         return cities;
          break;
        case 404:
          return throw ResourceNotFound('Cities');
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
  

  Future<List<CountryState>> fetchStates(int country , int page)async{
        await CheckInternet();
        String url = ApiUtil.STATES(country) + '?page=' + page.toString();
        http.Response response = await http.get(url ,headers:headers);

        switch (response.statusCode) {
          case 200:
            List<CountryState> states = [];
          var body = jsonDecode(response.body);
          for(var item in body['data']){
             states.add(
              CountryState.fromJson(item)
             );
         }
          return states;
            break;

          case 404:
             throw ResourceNotFound('States');
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


}