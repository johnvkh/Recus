import 'package:flutter/material.dart';
import '../Utility/Constants.dart';

class DefaultButtonWidget extends StatelessWidget {
  const DefaultButtonWidget(
      {Key? key, required this.press, required this.textValue})
      : super(key: key);
  final VoidCallback press;
  final String textValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: GestureDetector(
        onTap: press,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withOpacity(0.2),
                spreadRadius: 4,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              textValue,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Noto_Sans_Lao",
              ),
            ),
          ),
        ),
      ),
    );
  }
}
