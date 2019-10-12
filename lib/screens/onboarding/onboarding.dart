import 'package:flutter/material.dart';
import 'onboarding_model.dart';
import 'onboarding_screen.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  PageController _pageController;

  List<OnBoardingModel> screens = [
    OnBoardingModel(image: "assets/images/onboarding1.jpg" ,
                    title: "Welcome",
                    description: "Now were up in the big leagues gettingour turn at bat . The Brady Bunch that's the way we Brady Bunch..",
    ),

    OnBoardingModel(image: "assets/images/onboarding2.jpg" ,
      title: "Add To Cart",
      description: "Now were up in the big leagues gettingour turn at bat . The Brady Bunch that's the way we Brady Bunch..",
    ),

    OnBoardingModel(image: "assets/images/onboarding3.jpg" ,
      title: "Enjoy Purchase",
      description: "Now were up in the big leagues gettingour turn at bat . The Brady Bunch that's the way we Brady Bunch..",
    ),
  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(
      initialPage: 0
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: PageView.builder(
          controller: _pageController,
          itemCount: screens.length,
          itemBuilder: (BuildContext context , int position){
            return SingleOnBoarding(screens[position]);
          },
        ),
      ),
    );
  }
}
