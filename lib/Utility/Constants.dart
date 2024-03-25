import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);
const fontColor = Color(0xFF6F7783);
const Color kPrimaryColor = Color.fromRGBO(0, 123, 255, 1);
// const bbColorNew = Color.fromRGBO(1, 234, 243, 244);
const bgColorNew = Color.fromRGBO(234, 243, 244, 1);
const boxColors = Color.fromRGBO(253, 77, 45, 1);
const defaultPadding = 16.0;

String API_URL = "https://rescue.kenkolaos.com";

final kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'Noto_Sans_Lao',
);

final kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'Noto_Sans_Lao',
);

final kBoxDecorationStyle = BoxDecoration(
  color: Color(0xFF6CA8F1),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);