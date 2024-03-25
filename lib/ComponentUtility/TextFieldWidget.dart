import 'package:flutter/material.dart';

import '../Utility/Constants.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key? key,
    required this.txtTitle,
    required this.txtHintText,
    required this.prefixIcon,
    required this.obscureText,
    required this.textControl,
    required this.txtTitleColor,
  }) : super(key: key);
  final String txtTitle;
  final Color txtTitleColor;
  final String txtHintText;
  final Icon prefixIcon;
  final bool obscureText;
  final TextEditingController textControl;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          txtTitle,
          style: TextStyle(
            color: txtTitleColor,
            fontWeight: FontWeight.bold,
            fontFamily: 'Noto_Sans_Lao',
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: textControl,
            obscureText: obscureText,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'Noto_Sans_Lao',
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: prefixIcon,
              hintText: txtHintText,
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
