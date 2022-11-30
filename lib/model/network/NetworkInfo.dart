import 'dart:convert';
import 'package:flutter/foundation.dart';

const String baseURL =
    kDebugMode ? "https://dev.housetainer.tk/" : "https://housetainer.tk/";
const Map<String, String> baseHeaders = <String, String>{
  'Content-Type': 'application/json; charset=UTF-8',
};
