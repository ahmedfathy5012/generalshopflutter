import 'package:generalshop/exeptions/exeptions.dart';

class ProductUnit{
   int unit_id;
   String unit_code , unit_name ;

   ProductUnit(this.unit_id,this.unit_name,this.unit_code);

   ProductUnit.fromJson(Map<String , dynamic> jsonObject){

     assert(jsonObject['unit_id'] != null        , 'Unit Id Is Null');
     assert(jsonObject['unit_name'] != null      , 'Unit Name Is Null');
     assert(jsonObject['unit_code'] != null      , 'Unit Code Is Null');


     if(jsonObject['unit_id'] == null) throw       PropertyIsRequired('Unit ID');
     if(jsonObject['unit_name'] == null) throw     PropertyIsRequired('Unit Name');
     if(jsonObject['unit_code'] == null) throw     PropertyIsRequired('Unit Code');

     this.unit_id = jsonObject['unit_id'];
     this.unit_name = jsonObject['unit_name'];
     this.unit_code = jsonObject['unit_code'];
   }
}