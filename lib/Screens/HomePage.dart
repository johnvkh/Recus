import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../ComponentUtility/CardWidget.dart';
import 'AboutPage.dart';
import 'HistoryPage.dart';
import 'InFormPage.dart';
import 'LoginPage.dart';
import 'ProfilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                child: Text(
                  "ເມນູຫຼັກ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardWidget(
                    press: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => InformPage(),
                      );
                      Navigator.pushAndRemoveUntil(context, route, (route) => false);
                    },
                    icon: Icon(
                      Icons.medical_services,
                      size: 60,
                      color: Colors.white,
                    ),
                    textLabel: "ແຈ້ງເຫດ",
                    color1: Color.fromRGBO(8, 132, 216, 1),
                    color2: Color.fromRGBO(60, 182, 194, 1),
                  ),
                  SizedBox(width: 30),
                  CardWidget(
                    press: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => HistoryPage(),
                      );
                      Navigator.pushAndRemoveUntil(context, route, (route) => false);
                    },
                    icon: Icon(
                      Icons.history,
                      size: 60,
                      color: Colors.white,
                    ),
                    textLabel: "ປະຫວັດ",
                    color1: Color.fromRGBO(8, 132, 216, 1),
                    color2: Color.fromRGBO(60, 182, 194, 1),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardWidget(
                    press: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      );
                    },
                    icon: Icon(
                      Icons.account_circle,
                      size: 60,
                      color: Colors.white,
                    ),
                    textLabel: "ບັນຊີ",
                    color1: Color.fromRGBO(8, 132, 216, 1),
                    color2: Color.fromRGBO(60, 182, 194, 1),
                  ),
                  SizedBox(width: 30),
                  CardWidget(
                    press: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => AboutPage(),
                      );
                      Navigator.pushAndRemoveUntil(context, route, (route) => false);
                    },
                    icon: Icon(
                      Icons.info,
                      size: 60,
                      color: Colors.white,
                    ),
                    textLabel: "ກ່ຽວກັບ",
                    color1: Color.fromRGBO(8, 132, 216, 1),
                    color2: Color.fromRGBO(60, 182, 194, 1),
                  ),
                ],
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
        initialActiveIndex: 0, //optional, default as 0
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
