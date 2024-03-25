import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../ComponentUtility/DefaultButtonWidget.dart';
import '../ComponentUtility/DialogPopupWidget.dart';
import '../ComponentUtility/TextAreaWidget.dart';
import '../Model/AccidentTypeBO.dart';
import '../Model/CenterBO.dart';
import '../Model/DistrictBO.dart';
import '../Model/ProvinceBO.dart';
import '../Utility/Constants.dart';
import '../Utility/ResponceCode.dart';
import '../Utility/StringUtils.dart';
import '../Utility/WidgetUtility.dart';
import 'AboutPage.dart';
import 'HistoryPage.dart';
import 'HomePage.dart';
import 'LoginPage.dart';
import 'ProfilePage.dart';
import 'package:http/http.dart' as http;

class InformPage extends StatefulWidget {
  const InformPage({Key? key}) : super(key: key);

  @override
  State<InformPage> createState() => _InformPageState();
}

class _InformPageState extends State<InformPage> {
  final TextEditingController complaintDetail = new TextEditingController();
  final TextEditingController thirdPhone = new TextEditingController();
  final TextEditingController complainTitle = new TextEditingController();

  bool loadProcessBar = false;
  ProvinceBO provinceBO = ProvinceBO();
  List<ProvinceBO> listProvince = [];

  DistrictBO districtBO = DistrictBO();
  List<DistrictBO> listDistrict = [];

  CenterBO centerBO = CenterBO();
  List<CenterBO> listCenter = [];

  AccidentTypeBO accidentTypeBO = AccidentTypeBO();
  List<AccidentTypeBO> listAccidentType = [];

  String? provinceId;
  String? districtId;
  String? centerId;
  String? accidentType;

  //17.980485, 102.637340
  double? lat;
  double? lng;
  XFile? xFile1;
  XFile? xFile2;

  File? file1;
  File? file2;

  String? image1;
  String? image2;
  String? nameImageUp1;
  String? nameImageUp2;
  String? memberId;

  //late BitmapDescriptor pinLocationIcon;

  Future<Null> loadProvinceInfo() async {
    try {
      var url = Uri.parse("${API_URL}/api/province/get_province.php");
      print("url:${url}");
      var response = await http.post(
        url,
        headers: requestHeaders(),
      );
      var respData = json.decode(utf8.decode(response.bodyBytes));
      print("respData:${respData}");
      if (respData['response_code'] == SUCCESS) {
        listProvince.clear();
        for (var map in respData['list']) {
          provinceBO = ProvinceBO.fromJson(map);
          listProvince.add(provinceBO);
        }
        setState(() {
          listProvince;
          loadProcessBar = true;
        });
      } else if (respData['response_code'] == NOT_FOUND_DATA) {
        setState(() {
          loadProcessBar = true;
          listProvince.clear();
        });
      }else {
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

  Future<Null> loadDistrictInfo(String proviceId) async {
    try {
      var url =
          Uri.parse("${API_URL}/api/district/get_district_by_provice_id.php");
      print("url:${url}");
      var response = await http.post(
        url,
        headers: requestHeaders(),
        body: json.encode({"province_id": "${proviceId}"}),
      );
      var respData = json.decode(utf8.decode(response.bodyBytes));
      print("respData:${respData}");
      if (respData['response_code'] == SUCCESS) {
        listDistrict.clear();
        for (var map in respData['list']) {
          districtBO = DistrictBO.fromJson(map);
          listDistrict.add(districtBO);
        }
        setState(() {
          listDistrict;
          loadProcessBar = true;
        });
      } else if (respData['response_code'] == NOT_FOUND_INFO) {
        setState(() {
          loadProcessBar = true;
          listDistrict.clear();
        });
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

  Future<Null> loadCenterInfo(String districtId) async {
    try {
      var url = Uri.parse(
          "${API_URL}/api/center_service/get_center_by_district_id.php");
      print("url:${url}");
      var response = await http.post(
        url,
        headers: requestHeaders(),
        body: json.encode({"district_id": "${districtId}"}),
      );
      var respData = json.decode(utf8.decode(response.bodyBytes));
      print("respData:${respData}");
      if (respData['response_code'] == SUCCESS) {
        listCenter.clear();
        for (var map in respData['list']) {
          centerBO = CenterBO.fromJson(map);
          listCenter.add(centerBO);
        }
        setState(() {
          listCenter;
          loadProcessBar = true;
        });
      } else if (respData['response_code'] == NOT_FOUND_INFO) {
        setState(() {
          loadProcessBar = true;
          listCenter.clear();
        });
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

  Future<Null> loadAccidentTypeInfo() async {
    try {
      var url = Uri.parse("${API_URL}/api/accident_type/get_accident_type.php");
      print("url:${url}");
      var response = await http.post(
        url,
        headers: requestHeaders(),
        body: json.encode({"district_id": "${districtId}"}),
      );
      var respData = json.decode(utf8.decode(response.bodyBytes));
      print("respData:${respData}");
      if (respData['response_code'] == SUCCESS) {
        listAccidentType.clear();
        for (var map in respData['list']) {
          accidentTypeBO = AccidentTypeBO.fromJson(map);
          listAccidentType.add(accidentTypeBO);
        }
        setState(() {
          listAccidentType;
          loadProcessBar = true;
        });
      } else if (respData['response_code'] == NOT_FOUND_INFO) {
        setState(() {
          loadProcessBar = true;
          listAccidentType.clear();
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
            Navigator.pushNamedAndRemoveUntil(
                context, '/login', (route) => false);
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
            Navigator.of(context).pop();
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
          Navigator.of(context).pop();
        },
      );
    }
  }

  Future<LocationData?> findLocaltion() async {
    Location location = Location();
    try {
      return location.getLocation();
    } catch (e) {
      return null;
    }
  }

  Future<Null> findLatLng() async {
    setState(() {
      loadProcessBar = false;
    });
    LocationData? locationData = await findLocaltion();
    setState(() {
      lat = locationData?.latitude!;
      lng = locationData?.longitude!;
      loadProcessBar = true;
    });
    print("lat:${lat}");
    print("lng:${lng}");
  }

  Future<Null> loadAgentInfo() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      memberId = preferences.getString('member_id').toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAgentInfo();
    findLatLng();
    loadAccidentTypeInfo();
    loadProvinceInfo();
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
      body: loadProcessBar
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: Text(
                        "ແຈ້ງເຫດ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          txtComplainTitle(),
                          SizedBox(height: 10),
                          chooseProviceWidget(),
                          SizedBox(height: 10),
                          chooseDistrictWidget(),
                          SizedBox(height: 10),
                          chooseCenterWidget(),
                          SizedBox(height: 10),
                          chooseAccidentTypeWidget(),
                          SizedBox(height: 10),
                          txtThridPhone(),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TextAreaWidget(
                              content: "ລາຍລະອຽດ",
                              textControl: complaintDetail,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  TextWidget("ຮູບທີ1", Colors.black87, 18,
                                      FontWeight.normal, TextAlign.center),
                                  GestureDetector(
                                    onTap: () {
                                      chooseImage1(ImageSource.camera);
                                    },
                                    child: xFile1 == null
                                        ? Image.asset(
                                            "assets/images/photo.png",
                                            width: 150,
                                            height: 150,
                                          )
                                        : Image.file(
                                            File(xFile1!.path),
                                            height: 150,
                                            width: 150,
                                          ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  TextWidget("ຮູບທີ2", Colors.black87, 18,
                                      FontWeight.normal, TextAlign.center),
                                  GestureDetector(
                                    onTap: () {
                                      chooseImage2(ImageSource.camera);
                                    },
                                    child: xFile2 == null
                                        ? Image.asset(
                                            "assets/images/photo.png",
                                            width: 150,
                                            height: 150,
                                          )
                                        : Image.file(
                                            File(xFile2!.path),
                                            height: 150,
                                            width: 150,
                                          ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          if (lat != null || lng != null) ShowMap(),
                          SizedBox(height: 10),
                          DefaultButtonWidget(
                            textValue: "ສົ່ງແຈ້ງເຫດ",
                            press: () {
                              if (complainTitle.text.isEmpty) {
                                DialogFail(
                                  context,
                                  "ແຈ້ງເຕືອນ!",
                                  "ກະລຸນາປ້ອນຫົວຂໍ້ແຈ້ງເຫດ",
                                );
                              } else if (lng.toString().isEmpty ||
                                  lat.toString().isEmpty) {
                                DialogFail(
                                  context,
                                  "ແຈ້ງເຕືອນ!",
                                  "ກະລຸນາເປີດຕຳແໜ່ງຂອງທ່ານ",
                                );
                              } else if (centerId.toString().isEmpty ||
                                  centerId == null) {
                                DialogFail(
                                  context,
                                  "ແຈ້ງເຕືອນ!",
                                  "ກະລຸນາເລືອກສູນກູ້ໄພ",
                                );
                              } else if (accidentType == null) {
                                DialogFail(
                                  context,
                                  "ແຈ້ງເຕືອນ!",
                                  "ກະລຸນາເລືອກປະເພດອຸປະຕິເຫດ",
                                );
                              } else if (image1 == null || image2 == null) {
                                DialogFail(
                                  context,
                                  "ແຈ້ງເຕືອນ!",
                                  "ກະລຸນາຖ່າຍຮູບໃຫ້ຄົບຖ້ວນ",
                                );
                              } else {
                                print("complainTitle:${complainTitle.text}");
                                print("memberId:${memberId.toString()}");
                                print(
                                    "conplaintDetail:${complaintDetail.text}");
                                print("centerId:${centerId.toString()}");
                                print("image1:${image1.toString()}");
                                print("image2:${image2.toString()}");
                                print("lng:${lng.toString()}");
                                print("lat:${lat.toString()}");
                                print(
                                    "accidentType:${accidentType.toString()}");
                                print("thirdPhone:${thirdPhone.text}");


                                evenSentComplain(
                                  complainTitle.text,
                                  memberId.toString(),
                                  complaintDetail.text,
                                  centerId.toString(),
                                  image1.toString(),
                                  image2.toString(),
                                  lng.toString(),
                                  lat.toString(),
                                  accidentType.toString(),
                                  thirdPhone.text,
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ShowDialog(),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.home, title: " ໜ້າຫຼັກ"),
          TabItem(icon: Icons.medical_services, title: 'ແຈ້ງເຫດ'),
          TabItem(icon: Icons.history, title: 'ປະຫວັດ'),
          TabItem(icon: Icons.account_circle, title: 'ບັນຊີ'),
          TabItem(icon: Icons.info, title: 'ກ່ຽວກັບ'),
        ],
        initialActiveIndex: 1, //optional, default as 0
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

  Future<Null> evenSentComplain(
    String accidentComplainTitle,
    String memberId,
    String description,
    String centerId,
    String firstImgPath,
    String secondImgPath,
    String longitude,
    String latitude,
    String accidentTypeId,
    String thirdPhone,
  ) async {
    try {
      DialogBuilder(context).showLoadingIndicator();
      print("userName evenLogin:${msisdn}");
      print("password evenLogin:${password}");
      var url = Uri.parse(
          "${API_URL}/api/accident_complaint/insert_accident_complaint.php");
      var response = await http.post(
        url,
        headers: requestHeaders(),
        body: json.encode({
          "accident_complain_title": "${accidentComplainTitle}",
          "member_id": "${memberId}",
          "description": "${description}",
          "center_id": "${centerId}",
          "first_img_path": "${firstImgPath}",
          "second_img_path": "${secondImgPath}",
          "longitude": "${longitude}",
          "latitude": "${latitude}",
          "accident_type_id": "${accidentTypeId}",
          "third_phone": "${thirdPhone}"
        }),
      );
      print('Response status: ${response.statusCode}');
      var respData = json.decode(response.body);
      print("respData=${respData}");
      if (respData['response_code'] == SUCCESS) {
        uploadImage1();
        uploadImage2();

        DialogBuilder(context).hideOpenDialog();
        DialogSucessfull(
          context,
          "ແຈ້ງເຕືອນ!",
          "ລົງທະບຽນສຳເລັດ!",
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          },
        );
      } else {
        DialogBuilder(context).hideOpenDialog();
        DialogFail(
          context,
          "ແຈ້ງເຕືອນ!",
          "ລະບົບຂັດຂ້ອງ ກະລຸນາຕິດຕໍ່ admin!!!",
        );
      }
    } catch (error) {
      DialogBuilder(context).hideOpenDialog();
      print("ERROR:${error.toString()}");
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

  Future<Null> chooseImage1(ImageSource imageSource) async {
    try {
      Random random = Random();
      int i = random.nextInt(10000000);
      nameImageUp1 = 'rescue$i.jpg';
      XFile? object = await ImagePicker().pickImage(
        source: imageSource,
        maxWidth: 150,
        maxHeight: 150,
      );
      setState(() {
        image1 = "/images/$nameImageUp1";
        xFile1 = object;
      });
    } catch (e) {
      return null;
    }
  }

  Future<Null> uploadImage1() async {
    print("xFile1!:${xFile1!.path}");
    print("nameImageUp1:${nameImageUp1}");
    String url = '${API_URL}/api/upload/uploadImage.php';
    print('url=>$url');
    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(xFile1!.path, filename: nameImageUp1);
      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print('responce =>>$value');
      });
    } catch (e) {
      print('Error:$e');
    }
  }

  Future<Null> uploadImage2() async {
    String url = '${API_URL}/api/upload/uploadImage.php';
    print('url=>$url');
    try {
      Map<String, dynamic> map = Map();
      map['file'] =
          await MultipartFile.fromFile(xFile2!.path, filename: nameImageUp2);
      FormData formData = FormData.fromMap(map);
      await Dio().post(url, data: formData).then((value) {
        print('responce =>>$value');
      });
    } catch (e) {
      print('Error:$e');
    }
  }

  Future<Null> chooseImage2(ImageSource imageSource) async {
    try {
      Random random = Random();
      int i = random.nextInt(10000000);
      nameImageUp2 = 'rescue$i.jpg';
      XFile? object = await ImagePicker().pickImage(
        source: imageSource,
        maxWidth: 200,
        maxHeight: 200,
      );
      setState(() {
        image2 = "/images/$nameImageUp2";
        xFile2 = object;
      });
    } catch (e) {
      return null;
    }
  }

  Widget ShowMap() {
    LatLng latLng = LatLng(lat!, lng!);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16.0,
    );
    return Container(
      height: 350,
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: GoogleMap(
          initialCameraPosition: cameraPosition,
          mapType: MapType.hybrid,
          onMapCreated: (controller) {},
          markers: myMarker(),
        ),
      ),
    );
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('My location'),
        position: LatLng(lat!, lng!),
        infoWindow: InfoWindow(title: 'My location', snippet: '$lat - $lng'),
      )
    ].toSet();
  }

  Padding txtComplainTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "ຫົວຂໍ້ແຈ້ງເຫດ",
            style: TextStyle(
              //color: txtTitleColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Noto_Sans_Lao',
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              //color: Color(0xFF6CA8F1),
              borderRadius: BorderRadius.circular(5.0),
            ),
            height: 60.0,
            child: TextField(
              controller: complainTitle,
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Noto_Sans_Lao',
              ),
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(
                  color: Colors.teal,
                )),
                contentPadding: EdgeInsets.only(top: 14, left: 20),
                hintText: "ຫົວຂໍ້ແຈ້ງເຕືອນ",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Noto_Sans_Lao',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding txtThridPhone() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "ເບີຕິດຕໍ່",
            style: TextStyle(
              //color: txtTitleColor,
              fontWeight: FontWeight.bold,
              fontFamily: 'Noto_Sans_Lao',
            ),
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              //color: Color(0xFF6CA8F1),
              borderRadius: BorderRadius.circular(5.0),
            ),
            height: 60.0,
            child: TextField(
              controller: thirdPhone,
              style: TextStyle(
                color: Colors.black87,
                fontFamily: 'Noto_Sans_Lao',
              ),
              decoration: InputDecoration(
                border: new OutlineInputBorder(
                    borderSide: new BorderSide(
                  color: Colors.teal,
                )),
                contentPadding: EdgeInsets.only(top: 14, left: 20),
                hintText: "ເບີຕິດຕໍ່",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Noto_Sans_Lao',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chooseAccidentTypeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextWidget(
            "ປະເພດອຸປະຕິເຫດ",
            Colors.black,
            16,
            FontWeight.bold,
            TextAlign.left,
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            isExpanded: true,
            hint: Text(
              "ເລືອກອຸປະຕິເຫດ",
              style: TextStyle(fontSize: 14),
            ),
            items: listAccidentType
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item.accidentTypeId,
                    child: Text(
                      "${item.accidentTypeName!}",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
            validator: (value) {
              if (value == null) {
                return null;
              }
              return value;
            },
            onChanged: (value) {
              setState(() {
                accidentType = value;
              });
              //loadCenterInfo(value.toString());
            },
            onSaved: (value) {
              setState(() {
                accidentType = value;
              });
            },
            buttonStyleData: const ButtonStyleData(
              height: 48.0,
              padding: EdgeInsets.only(left: 10, right: 10),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget chooseProviceWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextWidget(
            "ແຂວງ",
            Colors.black,
            16,
            FontWeight.bold,
            TextAlign.left,
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            isExpanded: true,
            hint: Text(
              "ເລືອກແຂວງ",
              style: TextStyle(fontSize: 14),
            ),
            items: listProvince
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item.provinceId,
                    child: Text(
                      "${item.provinceName!}",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
            validator: (value) {
              if (value == null) {
                return null;
              }
              return value;
            },
            onChanged: (value) {
              setState(() {
                provinceId = value;
                //loadProcessBar = false;
              });
              loadDistrictInfo(value.toString());
            },
            onSaved: (value) {
              setState(() {
                provinceId = value;
              });
            },
            buttonStyleData: const ButtonStyleData(
              height: 48.0,
              padding: EdgeInsets.only(left: 10, right: 10),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget chooseDistrictWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextWidget(
            "ເມືອງ",
            Colors.black,
            16,
            FontWeight.bold,
            TextAlign.left,
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            isExpanded: true,
            hint: Text(
              "ເລືອກເມືອງ",
              style: TextStyle(fontSize: 14),
            ),
            items: listDistrict
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item.districtId,
                    child: Text(
                      "${item.districtName!}",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
            validator: (value) {
              if (value == null) {
                return null;
              }
              return value;
            },
            onChanged: (value) {
              setState(() {
                districtId = value;
              });
              loadCenterInfo(value.toString());
            },
            onSaved: (value) {
              setState(() {
                districtId = value;
              });
            },
            buttonStyleData: const ButtonStyleData(
              height: 48.0,
              padding: EdgeInsets.only(left: 10, right: 10),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget chooseCenterWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: TextWidget(
            "ສູນກູ້ໄພ",
            Colors.black,
            16,
            FontWeight.bold,
            TextAlign.left,
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            isExpanded: true,
            hint: Text(
              "ເລືອກສູນກູ້ໄພ",
              style: TextStyle(fontSize: 14),
            ),
            items: listCenter
                .map(
                  (item) => DropdownMenuItem<String>(
                    value: item.centerId,
                    child: Text(
                      "${item.centerName!}",
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                )
                .toList(),
            validator: (value) {
              if (value == null) {
                return null;
              }
              return value;
            },
            onChanged: (value) {
              setState(() {
                centerId = value;
              });
            },
            onSaved: (value) {
              setState(() {
                centerId = value;
              });
            },
            buttonStyleData: const ButtonStyleData(
              height: 48.0,
              padding: EdgeInsets.only(left: 10, right: 10),
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
            ),
            dropdownStyleData: DropdownStyleData(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
