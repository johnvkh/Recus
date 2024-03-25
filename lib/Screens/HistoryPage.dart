import 'dart:async';
import 'dart:convert';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../ComponentUtility/DialogPopupWidget.dart';
import '../ComponentUtility/HistoryItemWidget.dart';
import '../Model/AccidentComplaintBO.dart';
import '../Utility/Constants.dart';
import '../Utility/ResponceCode.dart';
import '../Utility/StringUtils.dart';
import '../Utility/WidgetUtility.dart';
import 'AboutPage.dart';
import 'HistoryDetail.dart';
import 'HomePage.dart';
import 'InFormPage.dart';
import 'LoginPage.dart';
import 'ProfilePage.dart';
import 'package:http/http.dart' as http;

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  AccidentComplaintBO accidentComplaintBO = AccidentComplaintBO();
  List<AccidentComplaintBO> listAccidentComplaint = [];

  bool loadProcessBar = false;

  Future<Null> loadHistory() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String memberId = preferences.getString('member_id').toString();
      var url =
          Uri.parse("${API_URL}/api/accident_complaint/get_history_by_id.php");
      print("url:${url}");
      var response = await http.post(
        url,
        headers: requestHeaders(),
        body: json.encode({"member_id": "${memberId}"}),
      );
      var respData = json.decode(utf8.decode(response.bodyBytes));
      print("respData:${respData}");
      if (respData['response_code'] == SUCCESS) {
        listAccidentComplaint.clear();
        for (var map in respData['list']) {
          accidentComplaintBO = AccidentComplaintBO.fromJson(map);
          listAccidentComplaint.add(accidentComplaintBO);
        }
        setState(() {
          listAccidentComplaint;
          loadProcessBar = true;
        });
      } else if (respData['response_code'] == NOT_FOUND_DATA) {
        setState(() {
          loadProcessBar = true;
          listAccidentComplaint.clear();
        });
      } else if (respData['response_code'] == SESSION_EXPRIE) {
        setState(() {
          loadProcessBar = true;
        });
        DialogFailConfirm(
          context,
          "ແຈ້ງເຕືອນ!",
          "Session ຫົມດອາຍຸ ກະລຸນາລອງໃຫ່ມ",
          () {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => LoginPage(),
            );
            Navigator.pushAndRemoveUntil(context, route, (route) => false);
          },
        );
      } else {
        setState(() {
          loadProcessBar = true;
        });
        print("error");
        DialogFailConfirm(
          context,
          "ແຈ້ງເຕືອນ!",
          "system error pleace try again!!!",
          () {
            MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => LoginPage(),
            );
            Navigator.pushAndRemoveUntil(context, route, (route) => false);
          },
        );
      }
    } catch (error) {
      setState(() {
        loadProcessBar = true;
      });
      print("error2:${error}");
      DialogFailConfirm(
        context,
        "ແຈ້ງເຕືອນ!",
        "system error pleace try again!!!",
        () {
          MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => LoginPage(),
          );
          Navigator.pushAndRemoveUntil(context, route, (route) => false);
        },
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadHistory();
  }

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
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextWidget("ປະຫັວດການແຈ້ງເຫດ", Colors.black87, 20,
                  FontWeight.bold, TextAlign.center),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: loadProcessBar
                    ? BuildListHistory()
                    : Center(
                        child: Lottie.asset('assets/lottie/loading.json',
                            width: 100, height: 100),
                      ),
              ),
            ),
          ],
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
        initialActiveIndex: 2, //optional, default as 0
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

  Widget BuildListHistory() => listAccidentComplaint.length == 0
      ? Column(
          children: [
            Container(
              child: Image.asset("assets/images/element_not_found.png"),
            ),
            TextWidget(
              "ບໍ່ພົບຂໍ້ມູນ",
              Colors.black,
              16,
              FontWeight.bold,
              TextAlign.left,
            ),
          ],
        )
      : ListView.builder(
          itemCount: listAccidentComplaint.length,
          itemBuilder: (context, index) => HistoryItemWidget(
            accidentComplaintBO: listAccidentComplaint[index],
            press: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => HistoryDetail(accidentComplaintBO: listAccidentComplaint[index]),
              );
              Navigator.pushAndRemoveUntil(context, route, (route) => false);
            },
          ),
        );
}
