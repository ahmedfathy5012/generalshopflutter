

class Reviewer{
  String first_name, last_name , email , formatted_name;

  Reviewer(this.first_name,this.last_name,this.email,this.formatted_name);

  Reviewer.fromJson(Map<String , dynamic> jsonObject){
    this.first_name = jsonObject['first_name'];
    this.last_name = jsonObject['last_name'];
    this.email = jsonObject['email'];
    this.formatted_name = jsonObject['formatted_name'];
  }
}