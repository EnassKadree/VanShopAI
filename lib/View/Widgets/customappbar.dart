import 'package:flutter/material.dart';
import 'package:vanshopai/constants.dart';

class MyAppBar
{
  
  static CustomAppBar() 
  {
    return AppBar
    (
      backgroundColor: Colors.orange,
      iconTheme: const IconThemeData(color: Colors.white),
      flexibleSpace: Container
      (
        decoration: BoxDecoration
        (
          gradient: LinearGradient(colors: gradientColors)
        ),
      ),
    );
  }
}