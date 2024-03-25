import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'HistoryPage.dart';
import 'HomePage.dart';
import 'InFormPage.dart';
import 'LoginPage.dart';
import 'ProfilePage.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Shimmer.fromColors(
                child: Container(
                  child: Text(
                    'Rescus',
                    style: TextStyle(fontSize: 22.0, fontFamily: 'Pacifico'),
                  ),
                ),
                baseColor: Colors.white,
                highlightColor: Colors.red),
          ],
        ),
        actions: <Widget>[
          Row(
            children: [
              // IconButton(
              //   icon: Icon(Icons.notifications),
              //   onPressed: () {},
              // ),
              IconButton(
                icon: Icon(Icons.power_settings_new),
                onPressed: () async {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  );
                  Navigator.pushAndRemoveUntil(
                      context, route, (route) => false);
                },
              ),
            ],
          )
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Shimmer.fromColors(
                child: Container(
                  child: Text(
                    'Rescue',
                    style: TextStyle(fontSize: 26, fontFamily: 'Pacifica'),
                  ),
                ),
                baseColor: Colors.red,
                highlightColor: Colors.white70,
              ),
              SizedBox(height: 50),
              Text(
                'version 1.0.0.2',
                style: TextStyle(fontSize: 26, fontFamily: 'Pacifica'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home, title: " ໜ້າຫຼັກ"),
          TabItem(icon: Icons.medical_services, title: 'ແຈ້ງເຫດ'),
          TabItem(icon: Icons.history, title: 'ປະຫວັດ'),
          TabItem(icon: Icons.account_circle, title: 'ບັນຊີ'),
          TabItem(icon: Icons.info, title: 'ກ່ຽວກັບ'),
        ],
        initialActiveIndex: 4, //optional, default as 0
        onTap: (int i) {
          print('click index=$i');
          if (i == 0) {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => HomePage(),
            );
            Navigator.pushAndRemoveUntil(context, route, (route) => false);
          } else if (i == 1) {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => InformPage(),
            );
            Navigator.pushAndRemoveUntil(context, route, (route) => false);
          } else if (i == 2) {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => HistoryPage(),
            );
            Navigator.pushAndRemoveUntil(context, route, (route) => false);
          } else if (i == 3) {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => ProfilePage(),
            );
            Navigator.pushAndRemoveUntil(context, route, (route) => false);
          } else if (i == 4) {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => AboutPage(),
            );
            Navigator.pushAndRemoveUntil(context, route, (route) => false);
          }
        },
      ),
    );
  }
}
