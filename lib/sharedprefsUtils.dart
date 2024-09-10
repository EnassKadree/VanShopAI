import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vanshopai/View/Auth/Login/login.dart';
import 'package:vanshopai/View/Company/companyhome.dart';
import 'package:vanshopai/View/Representative/rephome.dart';

late SharedPreferences prefs;

Future<void> initSharedPreferences() async 
{
  prefs = await SharedPreferences.getInstance();
}

Map<String, dynamic>? getUserData()  
{
  String? userDataString = prefs.getString('userData');
  print(userDataString);

  if (userDataString != null) 
  {
    Map<String, dynamic> userData = jsonDecode(userDataString);
    return userData;
  }
  return null;
}

Widget getHomePage(String userType) 
{
  if (userType == 'Company') 
  {
    return const CompanyHome();
  } 
  else if (userType == 'Representative') 
  {
    return const RepresentativeHome();
  } 
  else if (userType == 'Distributor') 
  {

  } 
  else if (userType == 'Store') 
  {

  }
  return LoginPage();
}