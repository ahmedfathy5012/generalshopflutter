import 'package:flutter/material.dart';
import 'onboarding_model.dart';
import '../utilities/screen_config.dart';

class SingleOnBoarding extends StatelessWidget {
  final OnBoardingModel onBoardingModel;
  SingleOnBoarding(this.onBoardingModel);
  
   ScreenConfig screenConfig;
   WidgetSize widgetSize;


  @override
  Widget build(BuildContext context) {
     
     screenConfig = ScreenConfig(context);
     widgetSize = WidgetSize(screenConfig);

    return Column(
      children: <Widget>[
        SizedBox(
              width: MediaQuery.of(context).size.width*0.95,
              height: MediaQuery.of(context).size.height*0.3,
              child: Image(
              fit: BoxFit.cover,
              image: ExactAssetImage(onBoardingModel.image)),
        ),
        SizedBox(height: 24,),
        Text(onBoardingModel.title,
        style: TextStyle(
          fontSize: widgetSize.titleFontSize,
          fontWeight: FontWeight.bold,
        ),
        ),
        SizedBox(height: 5,),
        Padding(
          padding: const EdgeInsets.only(left: 22,right: 22),
          child: Text(onBoardingModel.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 1.5,
            fontSize: widgetSize.descriptionFontSize,
            fontWeight: FontWeight.w400,
            color: Colors.blueGrey,
          ),
          ),
        )
      ],
    );
  }
}
