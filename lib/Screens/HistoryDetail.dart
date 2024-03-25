import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../ComponentUtility/TextFieldWidget.dart';
import '../Model/AccidentComplaintBO.dart';
import '../Utility/Constants.dart';
import '../Utility/WidgetUtility.dart';
import 'AboutPage.dart';
import 'HistoryPage.dart';
import 'HomePage.dart';
import 'InFormPage.dart';
import 'LoginPage.dart';
import 'ProfilePage.dart';

class HistoryDetail extends StatefulWidget {
  const HistoryDetail({Key? key, required this.accidentComplaintBO})
      : super(key: key);

  @override
  State<HistoryDetail> createState() => _HistoryDetailState();
  final AccidentComplaintBO accidentComplaintBO;
}

class _HistoryDetailState extends State<HistoryDetail> {
  final TextEditingController complainTitle = new TextEditingController();
  final TextEditingController complainDate = new TextEditingController();
  final TextEditingController centerName = new TextEditingController();
  final TextEditingController complaintDetail = new TextEditingController();
  final TextEditingController complainStatus = new TextEditingController();
  final TextEditingController accidentTypeName = new TextEditingController();

  double? lat;
  double? lng;

  Future<Null> loadInfo() async {
    setState(() {
      complainTitle.text = widget.accidentComplaintBO.accidentComplainTitle!;
      complainDate.text = widget.accidentComplaintBO.complainDate!;
      centerName.text = widget.accidentComplaintBO.centerName!;
      complaintDetail.text = widget.accidentComplaintBO.description!;
      complainStatus.text = widget.accidentComplaintBO.complainStatus!;
      accidentTypeName.text = widget.accidentComplaintBO.complainStatus!;
      lat = double.parse(widget.accidentComplaintBO.latitude!);
      lng = double.parse(widget.accidentComplaintBO.longitude!);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadInfo();
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
                icon: Icon(Icons.notifications),
                onPressed: () {},
              ),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                "ລາຍລະອຽດປະຫັວດ",
                Colors.black87,
                20,
                FontWeight.bold,
                TextAlign.center,
              ),
              SizedBox(height: 20.0),
              TextFieldWidget(
                textControl: complainTitle,
                txtTitle: "ຫົວຂໍ້ແຈ້ງເຫດ",
                txtTitleColor: Colors.black87,
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
                txtHintText: "ຫົວຂໍ້ແຈ້ງເຫດ",
                obscureText: false,
              ),
              SizedBox(height: 10.0),
              TextFieldWidget(
                textControl: complainDate,
                txtTitle: "ວັນທີແຈ້ງເຫດ",
                txtTitleColor: Colors.black87,
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
                txtHintText: "ວັນທີແຈ້ງເຫດ",
                obscureText: false,
              ),
              SizedBox(height: 10.0),
              TextFieldWidget(
                textControl: accidentTypeName,
                txtTitle: "ປະເພດແຈ້ງເຫດ",
                txtTitleColor: Colors.black87,
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
                txtHintText: "ປະເພດແຈ້ງເຫດ",
                obscureText: false,
              ),
              SizedBox(height: 10.0),
              TextFieldWidget(
                textControl: centerName,
                txtTitle: "ສູນກູ້ໄພ",
                txtTitleColor: Colors.black87,
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
                txtHintText: "ສູນກູ້ໄພ",
                obscureText: false,
              ),
              SizedBox(height: 10.0),
              //complainStatus
              TextFieldWidget(
                textControl: complainStatus,
                txtTitle: "ສະຸານະການແຈ້ງເຫດການ",
                txtTitleColor: Colors.black87,
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
                txtHintText: "ສະຸານະການແຈ້ງເຫດການ",
                obscureText: false,
              ),
              SizedBox(height: 10.0),
              TextFieldWidget(
                textControl: complaintDetail,
                txtTitle: "ລາຍລະອຽດ",
                txtTitleColor: Colors.black87,
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
                txtHintText: "ລາຍລະອຽດ",
                obscureText: false,
              ),
              SizedBox(height: 10.0),
              TextWidget(
                "ຮູບທີ1",
                Colors.black87,
                18,
                FontWeight.normal,
                TextAlign.center,
              ),
              Image.network(
                "${API_URL}${widget.accidentComplaintBO.firstImgPath}",
                width: 200,
                height: 200,
              ),
              TextWidget(
                "ຮູບທີ2",
                Colors.black87,
                18,
                FontWeight.normal,
                TextAlign.center,
              ),
              Image.network(
                "${API_URL}${widget.accidentComplaintBO.secondImgPath}",
                width: 200,
                height: 200,
              ),
              SizedBox(height: 10.0),
              if (lat != null || lng != null) ShowMap(),
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
}
