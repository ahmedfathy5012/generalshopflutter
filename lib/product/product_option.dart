
class ProductOption{
String option_name;
List<String> options;


ProductOption(this.option_name,this.options);

ProductOption.fromJson(List<Map<String , dynamic>> jsonObject){
  options = [];
  for(var itemOptions in jsonObject){
     options.add(itemOptions['']);
  }
}

}