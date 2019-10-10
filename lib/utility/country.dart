class Country{
  int country_id;
  String country_name , currency , capital ;

  Country(this.country_id,this.country_name,this.currency,this.capital);

  Country.fromJson(Map<String,dynamic> jsonObject){
    this.country_id = jsonObject['country_id'];
    this.country_name = jsonObject['country_name'];
    this.currency = jsonObject[currency];
    this.capital = jsonObject['capital'];
  }
}