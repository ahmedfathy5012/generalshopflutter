import 'package:flutter/material.dart';
import 'onboarding_model.dart';
import 'onboarding_screen.dart';
import '../utilities/screen_utilities.dart';
import '../utilities/screen_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../home_page.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  PageController _pageController;
  double screenWidth;
  double screenHeight;
  int currentIndex =0 ;
  bool lastPage = false ;

 


  List<OnBoardingModel> screens = [
    OnBoardingModel(image: "assets/images/onboarding.png" ,
                    title: "Welcome",
                    description: "Now were up in the big leagues gettingour turn at bat . The Brady Bunch that's the way we Brady Bunch..",
    ),

    OnBoardingModel(image: "assets/images/onboarding.png" ,
      title: "Add To Cart",
      description: "Now were up in the big leagues gettingour turn at bat . The Brady Bunch that's the way we Brady Bunch..",
    ),

    OnBoardingModel(image: "assets/images/onboarding.png" ,
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

  ScreenConfig screenConfig1;
  WidgetSize widgetSize;
  @override
  Widget build(BuildContext context) {
     

      screenConfig1 = ScreenConfig(context);
      widgetSize = WidgetSize(screenConfig1);



    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    double _mt =  screenHeight*0.2;

    ScreenConfig screenConfig = ScreenConfig(context) ;
    print(screenConfig.screenType);


    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
        children: <Widget>[
           Flexible(
                        child: Container(
        padding: EdgeInsets.only(top: _mt),
        height: screenHeight,
        width:  screenWidth,
        child: PageView.builder(
          controller: _pageController,
          itemCount: screens.length,
          itemBuilder: (BuildContext context , int position){
              return SingleOnBoarding(screens[position]);
          },
          onPageChanged: (int index){
            setState(() {
             currentIndex = index;
             if(index == screens.length-1){
               lastPage = true;
             }else{
               lastPage = false;
             }
            });
          },
        ),
      ),
           ),
      
      Transform.translate(
        offset: Offset(0,-(screenHeight*.15)),
              child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _drawDots(screens.length),            
          ),
        ),
      ),

        (lastPage)? _showButton() : Container() ,  // START BUTTON
      
        ],
      ),
    );
  }


  Widget _showButton(){
    
    double offset = (screenConfig1.screenType == ScreenType.SMALL) ? 0.05 : 0.1 ;
    
    return  Container(
         child: Transform.translate(
           offset: Offset(0,-(screenHeight*offset)),
           child: SizedBox(
             width: screenWidth*0.75,
             height: widgetSize.buttonHeight,
               child: RaisedButton(
                 shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(34)),
                 color: ScreenUtilties.mainBlue,
               onPressed: () async{
                 var pref = await SharedPreferences.getInstance();
                 pref.setBool('is_seen',true);
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context)=>HomePage())
                 );
               },
               child: Text('START',
               style: TextStyle(
                 color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontSize: widgetSize.buttonFontSize,
                 letterSpacing: 3,
               ),
               ),
             ),
           ),
         ),
       );
  }

  List<Widget> _drawDots(int qty){
    List<Widget> widgets = [] ;
    for (var i = 0; i < qty; i++) {
      widgets.add(
        Container(
                  decoration: BoxDecoration(
                 color: (i == currentIndex)? ScreenUtilties.mainBlue : ScreenUtilties.lightGrey , 
                 borderRadius: BorderRadius.circular(5)
                ),
                width: widgetSize.pagerDotWidth,
                height: widgetSize.pagerDotHeight,       
                margin: (i==(qty-1))? EdgeInsets.only(right: 0) : EdgeInsets.only(right: 24)
                        
              ),
      );
    }
    return widgets;
  }
}
