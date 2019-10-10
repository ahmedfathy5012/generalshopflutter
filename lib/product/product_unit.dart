

class ProductUnit{
   int unit_id;
   String unit_code , unit_name ;

   ProductUnit(this.unit_id,this.unit_name,this.unit_code);

   ProductUnit.fromJson(Map<String , dynamic> jsonObject){
     this.unit_id = jsonObject['unit_id'];
     this.unit_name = jsonObject['unit_name'];
     this.unit_code = jsonObject['unit_code'];
   }
}