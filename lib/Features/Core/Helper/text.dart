  import 'package:flutter/material.dart';

Widget TitleText(String title, {double fontSize = 24}) 
  {
    return Text
    (
      title,
      style: TextStyle(
        color: Colors.orange[700]!,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }