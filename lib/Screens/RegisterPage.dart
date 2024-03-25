import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rescue_app/Screens/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ComponentUtility/DefaultButtonWidget.dart';
import '../ComponentUtility/DialogPopupWidget.dart';
import '../ComponentUtility/TextFieldWidget.dart';
import '../Utility/Constants.dart';
import '../Utility/ResponceCode.dart';
import '../Utility/StringUtils.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController msisdn = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  final TextEditingController confirmPassword = new TextEditingController();
  final TextEditingController fullName = new TextEditingController();
  final TextEditingController address = new TextEditingController();

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
                        'ລົງທະບຽນບັນຊີ',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Noto_Sans_Lao',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFieldWidget(
                        textControl: fullName,
                        txtTitle: "ຊື່ ແລະ ນາມສະກຸນ",
                        txtTitleColor:Colors.white70,
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
                        txtTitleColor:Colors.white70,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.white,
                        ),
                        txtHintText: "ກະລຸນາປ້ອນເບີໂທ",
                        obscureText: false,
                      ),
                      SizedBox(height: 20.0),
                      TextFieldWidget(
                        textControl: password,
                        txtTitle: "ລະຫັດຜ່ານ",
                        txtTitleColor:Colors.white70,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        txtHintText: "ກະລຸນາປ້ອນລະຫັດຜ່ານ",
                        obscureText: true,
                      ),
                      SizedBox(height: 20.0),
                      TextFieldWidget(
                        textControl: confirmPassword,
                        txtTitle: "ຢືນຍັນລະຫັດຜ່ານ",
                        txtTitleColor:Colors.white70,
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.white,
                        ),
                        txtHintText: "ຢືນຍັນລະຫັດຜ່ານ",
                        obscureText: true,
                      ),
                      SizedBox(height: 20.0),
                      TextFieldWidget(
                        textControl: address,
                        txtTitle: "ທີ່ຢູ່",
                        txtTitleColor:Colors.white70,
                        prefixIcon: Icon(
                          Icons.home_filled,
                          color: Colors.white,
                        ),
                        txtHintText: "ກະລຸນາປ້ອນທີ່ຢູ່",
                        obscureText: false,
                      ),
                      DefaultButtonWidget(
                        textValue: "ລົງທະບຽນ",
                        press: () {
                          evenRegister(
                            msisdn.text,
                            password.text,
                            confirmPassword.text,
                            fullName.text,
                            address.text,
                          );
                        },
                      ),
                      _buildLoginBtn(),
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

  Future<Null> evenRegister(
    String msisdn,
    String password,
    String confirmPassword,
    String fullName,
    String address,
  ) async {
    try {
      buildShowDialog(context);
      if (password != confirmPassword) {
        DialogFail(
          context,
          "ແຈ້ງເຕືອນ!",
          "ການຢືນຢັນລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ",
        );
      } else {
        print("userName evenLogin:${msisdn}");
        print("password evenLogin:${password}");
        var url = Uri.parse("${API_URL}/api/member/insert_member.php");
        var response = await http.post(
          url,
          headers: requestHeaders(),
          body: json.encode({
            "fullname": "${fullName}",
            "msisdn": "${msisdn}",
            "password": "${password}",
            "address": "${address}",
            "member_status": "Active",
          }),
        );
        print('Response status: ${response.statusCode}');
        var respData = json.decode(utf8.decode(response.bodyBytes));
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
                  builder: (context) => LoginPage(),
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

  Widget _buildLoginBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'ຕ້ອງການເຂົ້າລະບົບບໍ? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'ເຂົ້າລະບົບ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
