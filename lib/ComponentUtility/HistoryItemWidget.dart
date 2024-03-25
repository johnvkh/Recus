import 'package:flutter/material.dart';
import '../Model/AccidentComplaintBO.dart';
import '../Utility/WidgetUtility.dart';

class HistoryItemWidget extends StatelessWidget {
  const HistoryItemWidget({
    Key? key,
    required this.accidentComplaintBO,
    required this.press,
  }) : super(key: key);
  final AccidentComplaintBO accidentComplaintBO;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    //String imagePath =
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, left: 4, right: 4, top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(3, 4),
                )
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 5),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: accidentComplaintBO.accidentTypeId == 3
                          ? Image.asset("assets/images/fire.png")
                          : Image.asset("assets/images/road.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                          accidentComplaintBO.accidentComplainTitle!,
                          Colors.black87,
                          16,
                          FontWeight.normal,
                          TextAlign.center),
                      SizedBox(height: 1),
                      TextWidget(
                          accidentComplaintBO.centerName!,
                          Colors.black87,
                          12,
                          FontWeight.normal,
                          TextAlign.center),
                      SizedBox(height: 1),
                      TextWidget(
                          accidentComplaintBO.complainDate!,
                          Colors.black87,
                          12,
                          FontWeight.normal,
                          TextAlign.center),
                    ],
                  ),
                ),
                const Expanded(
                  child: SizedBox(height: 10),
                ),
                GestureDetector(
                  onTap: press,
                  child: Container(
                    height: 49,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromRGBO(8, 132, 216, 1),
                          Color.fromRGBO(60, 182, 194, 1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "ລາຍລະອຽດ",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: "Noto_Sans_Lao",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          )
        ],
      ),
    );
  }
}
