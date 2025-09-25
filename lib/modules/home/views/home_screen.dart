import 'package:abashon_360_mobile/utils/styles/k_assets.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  double profileCompletion = 0.25; // 25%



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        shadowColor: Colors.lightGreen,
      ),
      drawer: Drawer(
        child: ListView(
          // padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              decoration: BoxDecoration(
                color: Colors.lightGreen,
                borderRadius: BorderRadius.circular(0),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios_new, size: 28),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Image.asset(
                      KAssetName.main_logo.imagePath,
                      width:100,
                      height: 44,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 2,),
                    Text(
                      "Name: Abashon 360",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),

                    ),
                    SizedBox(height: 2,),
                    Text(
                      "Phone: 01521332129",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),

                    ),
                  ],
                ),
              ),
            ),
            // 👉 Add your menu items here:
            ListTile(
              leading: Icon(Icons.apartment_rounded,size: 24,),
              title: Text('প্রপার্টি',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),ListTile(
              leading: Icon(Icons.apartment_rounded,size: 24,),
              title: Text('প্রপার্টি',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),ListTile(
              leading: Icon(Icons.apartment_rounded,size: 24,),
              title: Text('প্রপার্টি',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),ListTile(
              leading: Icon(Icons.apartment_rounded,size: 24,),
              title: Text('প্রপার্টি',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),ListTile(
              leading: Icon(Icons.apartment_rounded,size: 24,),
              title: Text('প্রপার্টি',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),ListTile(
              leading: Icon(Icons.apartment_rounded,size: 24,),
              title: Text('প্রপার্টি',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),ListTile(
              leading: Icon(Icons.apartment_rounded,size: 24,),
              title: Text('প্রপার্টি',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Section
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Welcome Guest",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Update your Profile",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Profile update card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Update your profile",
                      style: TextStyle(fontSize: 16),
                    ),
                    CircularPercentIndicator(
                      radius: 30.0,
                      lineWidth: 5.0,
                      percent: profileCompletion,
                      center: Text("${(profileCompletion * 100).toInt()}%"),
                      progressColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
