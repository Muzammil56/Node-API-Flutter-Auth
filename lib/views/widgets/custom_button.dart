import 'package:flutter/material.dart';
import 'package:node_flutter_auth/utils/constants.dart';

class CustomButton extends StatelessWidget {
  CustomButton({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          color: Constants.primarySwatch,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Constants.white,
          ),
        ),
      ),
    );
  }
}
