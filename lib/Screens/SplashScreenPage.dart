import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'LoginPage.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), (() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
          ),
        ),
      ),
    );
  }
}
