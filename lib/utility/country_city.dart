import 'package:generalshop/exeptions/exeptions.dart';

class CountryCity{
  int city_id;
  String city_name;

  CountryCity(this.city_id,this.city_name);

  CountryCity.fromJson(Map<String , dynamic>jsonObject){

    assert(jsonObject['city_id'] != null , 'City Id Is Null');
    assert(jsonObject['city_name'] != null , 'City Name Is Null');

    if(jsonObject['city_id'] == null )       throw PropertyIsRequired('City Id');
    if(jsonObject['city_name'] == null )     throw PropertyIsRequired('City Name');

     this.city_id = jsonObject['city_id'];
     this.city_name = jsonObject['city_name'];
  }
}