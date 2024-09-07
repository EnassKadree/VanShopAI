import 'package:flutter/material.dart';
import 'package:vanshopai/View/Company/Widgets/companydrawer.dart';
import 'package:vanshopai/View/Representative/addorderpage.dart';
import 'package:vanshopai/View/Representative/doneorders.dart';
import 'package:vanshopai/View/Representative/repunsubmittedpage.dart';
import 'package:vanshopai/View/General%20Widgets/homecard.dart';
import 'package:vanshopai/View/Company/Widgets/customappbar.dart';
import 'package:vanshopai/View/General%20Widgets/homeheader.dart';
import 'package:vanshopai/sharedprefsUtils.dart';

import 'incomingorders.dart';
import 'representativestores.dart';

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
              page: IncomingOrdersPage(),
            ),
            HomeCard(
              text: 'الطلبيات المنتهية',
              page: DoneOrdersPage(),
            ),
            HomeCard(
              text: 'زبائني',
              page: RepresentativeStores(),
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
