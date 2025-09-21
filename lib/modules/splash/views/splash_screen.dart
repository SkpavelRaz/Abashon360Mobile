import 'dart:async';

import 'package:abashon_360_mobile/domain/constants/app_colors.dart';
import 'package:abashon_360_mobile/domain/constants/uihelper.dart';
import 'package:abashon_360_mobile/modules/login/views/Login_screen.dart';
import 'package:abashon_360_mobile/utils/styles/k_assets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  State<StatefulWidget> createState()=> _SplashScreenState();

}

class _SplashScreenState extends State<SplashScreen>  {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:AppColors.scaffoldBackground,
      body: Padding(
        padding: EdgeInsetsGeometry.all(68),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(KAssetName.main_logo.imagePath)
          ],
        ),
      ),
    );
  }
}