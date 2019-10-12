import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:generalshop/screens/home_page.dart';
import 'package:generalshop/screens/onboarding/onboarding.dart';
void main() {


   runApp(GeneralShop());
}

class GeneralShop extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'General Shop',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }

}

