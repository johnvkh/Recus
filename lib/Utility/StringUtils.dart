import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

import 'Constants.dart';

String formatPrice(int price){
  final oCcy = new NumberFormat("#,###", "lo-LA");
  String value = oCcy.format(price);
  return value;
}

Map<String, String> requestHeaders() {
  return {
    'Content-Type': 'application/json',
  };
}
