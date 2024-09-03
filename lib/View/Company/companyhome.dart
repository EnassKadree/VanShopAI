import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vanshopai/View/Company/Widgets/companydrawer.dart';
import 'package:vanshopai/View/Company/Widgets/customappbar.dart';
import 'package:vanshopai/View/Company/companyproducts.dart';
import 'package:vanshopai/View/Company/companyrepresentatives.dart';
import 'package:vanshopai/View/Widgets/homecard.dart';
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
      body: const Column
      (
        children: 
        [
          HomeHeader(),
          Spacer(),
          HomeCard(text: 'منتجات الشركة', page: CompanyProducts()),
          HomeCard(text: 'مندوبو الشركة',page: CompanyRepresentatives()),
          Spacer(flex: 2,),
        ],
      )
    );
  }

}
