import 'package:generalshop/exeptions/exeptions.dart';

class CountryState{
  int state_id ;
  String state_name;

  CountryState(this.state_id,this.state_name);

  CountryState.fromJson(Map<String , dynamic> jsonObject){

    assert(jsonObject['state_id'] != null     , 'State Id Is Null');
    assert(jsonObject['state_name'] != null   , 'State Name Is Null');

    if(jsonObject['state_id'] == null)       throw   PropertyIsRequired('State Id');
    if(jsonObject['state_name'] == null)     throw   PropertyIsRequired('State name');

    this.state_id = jsonObject['state_id'];
    this.state_name = jsonObject['state_name'];
  }

}