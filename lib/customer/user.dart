import 'package:flutter/material.dart';



class User{

  String first_name;
  String last_name;
  String email;
  String api_token;
  int user_id;


  User(this.first_name,this.last_name,this.email,[this.api_token , this.user_id]);


  User.fromJson(Map<String,dynamic> jsonObject){   // create user through user data
      this.user_id = jsonObject['user_id'];
      this.first_name = jsonObject['first_name'];
      this.last_name = jsonObject['last_name'];
      this.api_token = jsonObject['api_token'];
      this.email = jsonObject['email'];
  }

}