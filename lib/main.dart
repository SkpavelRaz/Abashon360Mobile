import 'package:abashon_360_mobile/modules/splash/views/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Abashon());
}

class Abashon extends StatelessWidget{
  const Abashon({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Abashon360",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false
      ),
      home: SplashScreen(),

    );
  }


}


