import 'package:flutter/material.dart';
import 'package:generalshop/exeptions/exeptions.dart';


class User{

  String first_name;
  String last_name;
  String email;
  String api_token;
  int user_id;


  User(this.first_name,this.last_name,this.email,[this.api_token , this.user_id]);


  User.fromJson(Map<String,dynamic> jsonObject){   // create user through user data


    assert(jsonObject['user_id'] != null     ,'User ID Is Null');
    assert(jsonObject['first_name'] != null  ,'First Name Is Null');
    assert(jsonObject['last_name'] != null   ,'Last Name Is Null');
    assert(jsonObject['api_token'] != null   ,'Api Token Is Null');
    assert(jsonObject['email'] != null       ,'Email Is Null');

    if(jsonObject['user_id'] == null )        throw PropertyIsRequired('User Id');
    if(jsonObject['first_name'] == null )     throw PropertyIsRequired('First Name');
    if(jsonObject['Last_name'] == null )      throw PropertyIsRequired('Last Name');
    if(jsonObject['api_token'] == null )      throw PropertyIsRequired('Api Token');
    if(jsonObject['email'] == null )          throw PropertyIsRequired('Email');


      this.user_id = jsonObject['user_id'];
      this.first_name = jsonObject['first_name'];
      this.last_name = jsonObject['last_name'];
      this.api_token = jsonObject['api_token'];
      this.email = jsonObject['email'];
  }

}