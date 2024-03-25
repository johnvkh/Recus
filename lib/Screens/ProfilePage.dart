import 'dart:convert';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../ComponentUtility/DefaultButtonWidget.dart';
import '../ComponentUtility/DialogPopupWidget.dart';
import '../ComponentUtility/TextFieldWidget.dart';
import '../Utility/Constants.dart';
import '../Utility/ResponceCode.dart';
import '../Utility/StringUtils.dart';
import 'AboutPage.dart';
import 'HistoryPage.dart';
import 'HomePage.dart';
import 'InFormPage.dart';
import 'LoginPage.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? memberId;
  final TextEditingController msisdn = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController confirmPassword = new TextEditingController();
  final TextEditingController fullName = new TextEditingController();
  final TextEditingController address = new TextEditingController();

  @override
  void initState() {
    loadInfo();
    super.initState();
  }

  Future<void> loadInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      msisdn.text = preferences.getString('msisdn').toString();
      fullName.text = preferences.getString('fullname').toString();
      address.text = preferences.getString('address').toString();
      memberId = preferences.getString('member_id').toString();
    });
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/user.png",
                width: 120,
                height: 120,
              ),
              SizedBox(height: 30),
              TextFieldWidget(
                textControl: fullName,
                txtTitle: "ຊື່ ແລະ ນາມສະກຸນ",
                txtTitleColor: Colors.black87,
                prefixIcon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                txtHintText: "ກະລຸນາປ້ອນຊື່ ແລະ ນາມສະກຸນ",
                obscureText: false,
              ),
              SizedBox(height: 20.0),
              TextFieldWidget(
                textControl: msisdn,
                txtTitle: "ເບີໂທ",
                txtTitleColor: Colors.black87,
                prefixIcon: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                txtHintText: "ກະລຸນາປ້ອນເບີໂທ",
                obscureText: false,
              ),
              SizedBox(height: 20.0),
              TextFieldWidget(
                textControl: address,
                txtTitle: "ທີ່ຢູ່",
                txtTitleColor: Colors.black87,
                prefixIcon: Icon(
                  Icons.home_filled,
                  color: Colors.white,
                ),
                txtHintText: "ກະລຸນາປ້ອນທີ່ຢູ່",
                obscureText: false,
              ),
              SizedBox(height: 10.0),
              TextFieldWidget(
                textControl: password,
                txtTitle: "ລະຫັດຜ່ານ",
                txtTitleColor: Colors.black87,
                prefixIcon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                txtHintText: "ກະລຸນາປ້ອນລະຫັດຜ່ານ",
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              TextFieldWidget(
                textControl: confirmPassword,
                txtTitle: "ຢືນຍັນລະຫັດຜ່ານ",
                txtTitleColor: Colors.black87,
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
                txtHintText: "ຢືນຍັນລະຫັດຜ່ານ",
                obscureText: true,
              ),
              SizedBox(height: 10.0),
              DefaultButtonWidget(
                textValue: "ແກັໄຂບັນຊີ",
                press: () {
                  evenUpdate(
                    memberId!,
                    fullName.text,
                    msisdn.text,
                    password.text,
                    confirmPassword.text,
                    fullName.text,
                    address.text,
                  );
                },
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
        initialActiveIndex: 3, //optional, default as 0
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

  Future<Null> evenUpdate(
    String memberId,
    String fullname,
    String msisdn,
    String password,
    String confirmPassword,
    String fullName,
    String address,
  ) async {
    try {
      buildShowDialog(context);
      if (password.isEmpty) {
        DialogFail(
          context,
          "ແຈ້ງເຕືອນ!",
          "ກະລຸນາປ້ອນລະຫັດຜ່ານ",
        );
      }else
      if (confirmPassword.isEmpty) {
        DialogFail(
          context,
          "ແຈ້ງເຕືອນ!",
          "ກະລຸນາປ້ອນຢືນຍັນລະຫັດຜ່ານ",
        );
      }else
      if (password != confirmPassword) {
        DialogFail(
          context,
          "ແຈ້ງເຕືອນ!",
          "ການຢືນຢັນລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ",
        );
      } else {
        print("userName evenLogin:${msisdn}");
        print("password evenLogin:${password}");
        var url = Uri.parse("${API_URL}/api/member/update_member.php");
        var response = await http.post(
          url,
          headers: requestHeaders(),
          body: json.encode({
            "member_id": "2",
            "fullname": "${fullName}",
            "msisdn": "${msisdn}",
            "password": "${password}",
            "address": "${address}",
            "member_status": "Active",
          }),
        );
        print('Response status: ${response.statusCode}');
        var respData = json.decode(response.body);
        print("respData=${respData}");
        if (respData['response_code'] == SUCCESS) {
          setState(() {
            loadProcessBar = true;
          });
          DialogSucessfull(
            context,
            "ແຈ້ງເຕືອນ!",
            "ລົງທະບຽນສຳເລັດ!",
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
          );
        } else {
          DialogFailConfirm(
            context,
            "ແຈ້ງເຕືອນ!",
            "ລະບົບຂັດຂ້ອງ ກະລຸນາຕິດຕໍ່ admin!!!",
            () {
              Navigator.of(context).pop();
            },
          );
          setState(() {
            loadProcessBar = true;
          });
        }
      }
    } catch (error) {
      print("ERROR:${error.toString()}");
      setState(() {
        loadProcessBar = true;
      });
      DialogFailConfirm(
        context,
        "ແຈ້ງເຕືອນ!",
        "ລະບົບຂັດຂ້ອງ ກະລຸນາຕິດຕໍ່ admin!!!",
        () {
          Navigator.of(context).pop();
        },
      );
    }
  }
}
