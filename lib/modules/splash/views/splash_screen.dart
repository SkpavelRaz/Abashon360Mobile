import 'package:abashon_360_mobile/domain/constants/app_colors.dart';
import 'package:abashon_360_mobile/domain/constants/uihelper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  State<StatefulWidget> createState()=> _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.scaffoldBackground,
      body: Padding(
        padding: EdgeInsetsGeometry.all(68),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.CustomImage(img: "ic_abashon_logo.png")
          ],
        ),
      ),
    );
  }
}