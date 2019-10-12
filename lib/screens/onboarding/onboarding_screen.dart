import 'package:flutter/material.dart';
import 'onboarding_model.dart';

class SingleOnBoarding extends StatelessWidget {

  final OnBoardingModel onBoardingModel;

  SingleOnBoarding(this.onBoardingModel);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
            fit: BoxFit.cover,
            image: ExactAssetImage(onBoardingModel.image)),
        Text(onBoardingModel.title),
        Text(onBoardingModel.description)
      ],
    );
  }
}
