import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generalshop/screens/home_page.dart';
import 'package:generalshop/screens/onboarding/onboarding.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{

   var pref = await SharedPreferences.getInstance();
   bool isSeen = pref.getBool('is_seen');
   Widget homePage = HomePage();
   
   if(isSeen == null || !isSeen){
     homePage = OnBoarding();
   }  


   runApp(GeneralShop(homePage));
}

class GeneralShop extends StatelessWidget{

  final Widget homePage;
  GeneralShop(this.homePage);
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return MaterialApp(
      title: 'General Shop',
      home: homePage,
      debugShowCheckedModeBanner: false,
    );
  }

}

