import 'package:flutter/material.dart';


enum ScreenType{
  SMALL,MEDIUM , LARGE  
}


class ScreenConfig{
BuildContext context;


double screenWidth;
double screenHieght;
ScreenType screenType;


ScreenConfig(BuildContext context ){
   this.screenWidth = MediaQuery.of(context).size.width;
   this.screenHieght = MediaQuery.of(context).size.height;
   _setScreen();
   print(screenWidth);
}


void _setScreen(){
  if(screenWidth >=320 && screenWidth < 375){
    screenType = ScreenType.SMALL;
  }else if(screenWidth >= 375 && screenWidth < 414){
     screenType = ScreenType.MEDIUM;  
  }else if(screenWidth >=  414){
     screenType = ScreenType.LARGE;  
  }
}

}



class WidgetSize{
   double titleFontSize;
   double descriptionFontSize;
   ScreenConfig screenConfig;
   double pagerDotWidth;
   double pagerDotHeight;
   double buttonHeight;
   double buttonFontSize;


   WidgetSize(ScreenConfig screenConfig){
     this.screenConfig =screenConfig;
     _init();
   }
   
   void _init(){
     switch (this.screenConfig.screenType) {
       case ScreenType.SMALL:
        this.titleFontSize = 16;         
        this.descriptionFontSize = 14;
        this.pagerDotWidth = 25;
        this.pagerDotHeight = 4;
        this.buttonHeight=40;
        this.buttonFontSize=16;
         break;
      case ScreenType.MEDIUM:
      this.titleFontSize = 28;
      this.descriptionFontSize = 20;
      this.pagerDotWidth = 35;
      this.pagerDotHeight = 6;
      this.buttonHeight=60;
      this.buttonFontSize=22;
         break;
      case ScreenType.LARGE:
      this.titleFontSize = 28;
      this.descriptionFontSize = 20;
      this.pagerDotWidth = 35;
      this.pagerDotHeight = 6;
      this.buttonHeight=60;
      this.buttonFontSize=22;
         break;      
       default:
       this.titleFontSize = 28;
       this.descriptionFontSize = 20;
       this.pagerDotWidth = 35;
       this.pagerDotHeight = 6;
       this.buttonHeight=60;
       this.buttonFontSize=22;
         break;
     }
   }
}