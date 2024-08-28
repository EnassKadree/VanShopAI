import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vanshopai/View/Widgets/companydrawer.dart';
import 'package:vanshopai/View/Widgets/companyhomecard.dart';
import 'package:vanshopai/View/Widgets/customappbar.dart';
import 'package:vanshopai/View/Widgets/homeheader.dart';

class CompanyHome extends StatelessWidget 
{
  const CompanyHome({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: MyAppBar.CustomAppBar(),
      drawer: const CompanyDrawer(),
      body: Column
      (
        children: 
        [
          const HomeHeader(),
          const Spacer(),
          CompanyHomeCard(text: 'منتجات الشركة',),
          CompanyHomeCard(text: 'مندوبو الشركة',),
          const Spacer(flex: 2,),
        ],
      )
    );
  }

}
