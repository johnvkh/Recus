import 'package:flutter/material.dart';

import '../Utility/WidgetUtility.dart';

class TextAreaWidget extends StatelessWidget {
  const TextAreaWidget({
    Key? key,
    required this.textControl,
    required this.content,
  }) : super(key: key);
  final TextEditingController textControl;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          content,
          Colors.black,
          16,
          FontWeight.bold,
          TextAlign.left,
        ),
        SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.95,
          height: 90.0,
          child: TextField(
            maxLines: 10,
            showCursor: true,
            controller: textControl,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontFamily: 'NotoSansLao',
              ),
              // labelText: content,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.0),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 0.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
