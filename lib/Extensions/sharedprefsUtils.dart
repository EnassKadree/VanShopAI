import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vanshopai/Features/Auth/View/Login/login.dart';
import 'package:vanshopai/Features/Home/View/companyhome.dart';
import 'package:vanshopai/Features/Home/View/disthome.dart';
import 'package:vanshopai/Features/Home/View/rephome.dart';

late SharedPreferences prefs;

Future<void> initSharedPreferences() async 
{
  prefs = await SharedPreferences.getInstance();
}

Map<String, dynamic>? getUserData()  
{
  String? userDataString = prefs.getString('userData');

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
    return const DistributorHome();
  } 
  else if (userType == 'Store') 
  {

  }
  return LoginPage();
}