import 'package:flutter/material.dart';
import 'package:vanshopai/Widgets/customappbar.dart';
import 'package:vanshopai/Widgets/homeheader.dart';

class CompanyProducts extends StatelessWidget
{
  const CompanyProducts({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      drawer: const Drawer(),
      appBar: MyAppBar.CustomAppBar(),
      body: const HomeHeader(),
    );
  }
}