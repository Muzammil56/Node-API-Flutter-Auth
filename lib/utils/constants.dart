import 'package:flutter/material.dart';

class Constants {
  static String uri = "http://Your_IP_HERE:3000";
  static String uriWithSlash = "$uri/";
  static String signUpUrl = "$uri/api/signup";
  static String signInUrl = "$uri/api/signin";
  static String authenticationUrl = "$uri/tokenIsValid";
  static MaterialColor? primarySwatch = Colors.blue;
  static Color white = Colors.white;
}
