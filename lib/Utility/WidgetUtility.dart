import 'package:flutter/material.dart';

import 'Constants.dart';

Widget TextWidget(String content, Color color, double fontSize,
    FontWeight fontWeight, TextAlign textAlign) {
  return Text(
    content,
    style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        fontFamily: 'NotoSansLao'),
    textAlign: textAlign,
  );
}

Widget TextButtonWidget(VoidCallback onPass, String content, Color color,
    double fontSize, FontWeight fontWeight) {
  return TextButton(
    onPressed: onPass,
    child: Text(
      content,
      style: TextStyle(
        fontFamily: 'NotoSansLao',
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    ),
  );
}

Widget DividerWidget() {
  return Divider(
    color: Colors.black,
    height: 20,
    thickness: 1,
    indent: 1,
    endIndent: 1,
  );
}
