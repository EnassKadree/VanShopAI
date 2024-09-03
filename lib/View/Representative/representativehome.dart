import 'package:flutter/material.dart';
import 'package:vanshopai/View/Company/Widgets/companydrawer.dart';
import 'package:vanshopai/View/Representative/addorder.dart';
import 'package:vanshopai/View/Representative/repunsubmittedpage.dart';
import 'package:vanshopai/View/General%20Widgets/homecard.dart';
import 'package:vanshopai/View/Company/Widgets/customappbar.dart';
import 'package:vanshopai/View/Company/companyrepresentatives.dart';
import 'package:vanshopai/View/General%20Widgets/homeheader.dart';
import 'package:vanshopai/sharedprefsUtils.dart';

class RepresentativeHome extends StatelessWidget 
{
  const RepresentativeHome({super.key});

  @override
  Widget build(BuildContext context) 
  {
    if(prefs.getBool('submitted')!)
    {
      return Scaffold
      (
        appBar: MyAppBar.CustomAppBar(),
        drawer: const CompanyDrawer(),
        body: ListView(
          children: const 
          [
            HomeHeader(),
            SizedBox(
              height: 28,
            ),
            HomeCard(
              text: 'إنشاء طلبية لزبون',
              page: AddRepOrderPage(),
            ),
            HomeCard(
              text: 'الطلبيات الواردة',
              page: CompanyRepresentatives(),
            ),
            HomeCard(
              text: 'الطلبيات المنتهية',
              page: CompanyRepresentatives(),
            ),
            HomeCard(
              text: 'زبائني',
              page: CompanyRepresentatives(),
            ),
          ],
      ));
    }
    else
    {
      return const RepUnSubmittedPage();
    }
  }
}
