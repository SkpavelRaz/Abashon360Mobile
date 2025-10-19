import 'package:abashon_360_mobile/utils/styles/k_assets.dart';
import 'package:flutter/material.dart';

import '../../rent_collect/CollectHouseRent.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive column count
    int crossAxisCount = 1;
    if (screenWidth > 800) {
      crossAxisCount = 4;
    } else if (screenWidth > 500) {
      crossAxisCount = 3;
    } else if (screenWidth > 300) {
      crossAxisCount = 2;
    }
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0,
      automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.table_rows_sharp,size: 28,),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ],),
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
                      width: 100,
                      height: 44,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(height: 2),
                    Text(
                      "Name: Abashon 360",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 2),
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
              leading: Icon(Icons.apartment_rounded, size: 24),
              title: Text(
                'প্রপার্টি',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.apartment_rounded, size: 24),
              title: Text(
                'প্রপার্টি',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.apartment_rounded, size: 24),
              title: Text(
                'প্রপার্টি',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.apartment_rounded, size: 24),
              title: Text(
                'প্রপার্টি',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.apartment_rounded, size: 24),
              title: Text(
                'প্রপার্টি',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.apartment_rounded, size: 24),
              title: Text(
                'প্রপার্টি',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              onTap: () {
                // Navigate or close drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.apartment_rounded, size: 24),
              title: Text(
                'প্রপার্টি',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    // Profile Image
                    const CircleAvatar(
                      radius: 32,
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    ),
                    const SizedBox(width: 8),
                    // Name & Phone
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Abashon 360",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "01521332129",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        SizedBox(width: 12,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildTopInfoCard("বকেয়া ইউনিটের সংখ্যা", "12"),
                            _buildTopInfoCard("মাসিক খরচ", "৳ 8,500"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Due Rent & Monthly Expense

              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              physics: const NeverScrollableScrollPhysics(),
              // prevent nested scroll
              children: [
                _buildDashboardCard(
                  Icons.apartment_rounded,
                  "বাড়ি\nভাড়া সংগ্রহ",
                ),
                _buildDashboardCard(
                  Icons.playlist_add_check_rounded,
                  "ভবন\nরক্ষণাবেক্ষণ খরচ",
                ),
                _buildDashboardCard(
                  Icons.manage_history_rounded,
                  "ভবন\nরক্ষণাবেক্ষণের ইতিহাস",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(IconData icon, String title) {
    return InkWell(
      onTap: () {
        debugPrint("$title clicked");
        if(title=="বাড়ি\nভাড়া সংগ্রহ"){
          // Navigate
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CollectHouseRent(buildingData: title),
            ),
          );
        }else if(title=="ভবন\nরক্ষণাবেক্ষণ খরচ"){
          // Navigate
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CollectHouseRent(buildingData: title),
            ),
          );
        }else if(title=="ভবন\nরক্ষণাবেক্ষণের ইতিহাস"){
          // Navigate
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CollectHouseRent(buildingData: title),
            ),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.green),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Top Info Card for Due Rent & Monthly Expense
  Widget _buildTopInfoCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(
                fontSize: 11, fontWeight: FontWeight.w500, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
