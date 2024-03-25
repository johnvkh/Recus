import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rescue_app/Screens/RegisterPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ComponentUtility/DefaultButtonWidget.dart';
import '../Model/MemberBO.dart';
import '../Utility/Constants.dart';
import '../ComponentUtility/DialogPopupWidget.dart';
import '../Utility/ResponceCode.dart';
import '../Utility/StringUtils.dart';
import '../ComponentUtility/TextFieldWidget.dart';
import 'package:http/http.dart' as http;

import 'HomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

MemberBO memberBO = MemberBO();
List<MemberBO> listMember = [];
bool loadProcessBar = true;
final TextEditingController msisdn = new TextEditingController();
final TextEditingController password = new TextEditingController();


class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      msisdn.text = "8562098505680";
      password.text = "123";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'ເຂົ້າສູ່ລະບົບ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Noto_Sans_Lao',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextFieldWidget(
                        textControl: msisdn,
                        txtTitle: "ເບີໂທ",
                        txtTitleColor:Colors.white70,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        txtHintText: "ກະລຸນາປ້ອນເບີໂທ",
                        obscureText: false,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFieldWidget(
                        textControl: password,
                        txtTitle: "ລະຫັດຜ່ານ",
                        txtTitleColor:Colors.white70,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        txtHintText: "ກະລຸນາລະຫັດຜ່ານ",
                        obscureText: true,
                      ),
                      _buildForgotPasswordBtn(),
                      DefaultButtonWidget(
                        textValue: "ເຂົ້າສູ່ລະບົບ",
                        press: () {
                          evenLogin(msisdn.text, password.text);
                        },
                      ),
                      _buildSignupBtn(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Null> evenLogin(String msisdn, String password) async {
    try {
      buildShowDialog(context);
      print("userName evenLogin:${msisdn}");
      print("password evenLogin:${password}");
      var url = Uri.parse("${API_URL}/api/login_customer/login.php");
      var response = await http.post(
        url,
        headers: requestHeaders(),
        body: json.encode({"msisdn": "${msisdn}", "password": "${password}"}),
      );
      print('Response status: ${response.statusCode}');
      var respData = json.decode(utf8.decode(response.bodyBytes));
      print("respData=${respData}");
      if (respData['response_code'] == SUCCESS) {
        for (var map in respData['list']) {
          memberBO = MemberBO.fromJson(map);
          listMember.add(memberBO);
        }
        setState(() {
          memberBO;
          listMember;
        });
        setState(() {
          loadProcessBar = true;
        });
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('member_id', memberBO.memberId.toString());
        sharedPreferences.setString('fullname', memberBO.fullname.toString());
        sharedPreferences.setString('msisdn', memberBO.msisdn.toString());
        sharedPreferences.setString('address', memberBO.address.toString());
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => HomePage(),
        );
        Navigator.pushAndRemoveUntil(context, route, (route) => false);
      } else if (respData['responseCode'] == NOT_FOUND_ACCOUNT) {
        DialogFailConfirm(
          context,
          "ແຈ້ງເຕືອນ!",
          "ຊື່ເຂົ້າໃຊ້ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງກະລຸນາລອງໃຫ່ມ",
          () {
            Navigator.of(context).pop();
          },
        );
        setState(() {
          loadProcessBar = true;
        });
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

  Widget _buildForgotPasswordBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        alignment: Alignment.centerRight,
        child: GestureDetector(
          onTap: () {},
          child: Text(
            "ລືມລະຫັດຜ່ານ?",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Noto_Sans_Lao",
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RegisterPage(),
          ),
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'ຕ້ອງການລົງທະບຽນບໍ່? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
                fontFamily: "Noto_Sans_Lao",
              ),
            ),
            TextSpan(
              text: 'ລົງທະບຽນ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: "Noto_Sans_Lao",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
