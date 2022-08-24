import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void httpErrorHandle({
  required http.Response responce,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (responce.statusCode) {
    case 200:
      onSuccess();
      print("on success");
      break;

    case 400:
      showSnackBar(context, jsonDecode(responce.body)['msg']);
      print("2");
      break;

    case 500:
      showSnackBar(context, jsonDecode(responce.body)['error']);
      print("3");
      break;

    default:
      showSnackBar(context, responce.body);
      print("4");
      break;
  }
  ;
}
