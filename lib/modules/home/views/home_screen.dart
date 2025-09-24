import 'package:abashon_360_mobile/utils/styles/k_assets.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        backgroundColor: Colors.green,
        shadowColor: Colors.lightGreen,
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back_rounded),
                  Image.asset(KAssetName.main_logo.imagePath,width: 120,height: 80,),
                  const SizedBox(width: 4),
                  const Text(
                    "Abashon 360",
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400,wordSpacing: 50),
                  ),
                ],
              ),
            ),
            // 👉 Add your menu items here:
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Stack(

      ),
    );
  }
}
