import 'package:generalshop/exeptions/exeptions.dart';

class Country{
  int country_id;
  String country_name , currency , capital ;

  Country(this.country_id,this.country_name,this.currency,this.capital);

  Country.fromJson(Map<String,dynamic> jsonObject){

    assert(jsonObject['country_id'] != null      ,'Country Id Is Null' );
    assert(jsonObject['country_name'] != null    ,'Country Name Is Null' );
    assert(jsonObject['currency'] != null        ,'Country Currency Is Null' );
    assert(jsonObject['capital'] != null         ,'Country Capital Is Null' );



    if(jsonObject['country_id'] == null )        throw PropertyIsRequired('Country Id');
    if(jsonObject['country_name'] == null )      throw PropertyIsRequired('Country Name');
    if(jsonObject['currency'] == null )          throw PropertyIsRequired('Country Currency');
    if(jsonObject['capital'] == null )           throw PropertyIsRequired('Country Capital');


    this.country_id = jsonObject['country_id'];
    this.country_name = jsonObject['country_name'];
    this.currency = jsonObject['currency'];
    this.capital = jsonObject['capital'];
  }
}