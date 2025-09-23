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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Text("Home"),
        shadowColor: Colors.lightGreen,

      ),

      endDrawer: Drawer(
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(KAssetName.main_logo.imagePath,width: 150,height: 80,)
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Abashon360",
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
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
    );
  }
}
