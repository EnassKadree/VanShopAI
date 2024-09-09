// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import '../../Helper/text.dart';
import '../../sharedprefsUtils.dart';
import '../General Widgets/logutbuttton.dart';
import 'Widgets/profilecard.dart';


class RepProfile extends StatelessWidget 
{
  const RepProfile({super.key});


  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView
        (
          children: 
          [
            Row
            (
              children: 
              [
                TitleText('الملف الشخصي',fontSize: 32),
                const Spacer(),
                const LogoutButton()
              ],
            ),
            const SizedBox(height: 16),
            ProfileCard
            (
              title: 'الاسم التجاري',
              subtitle: prefs.getString('name') ?? 'لا يوجد',
            ),
            ProfileCard
            (
              title: 'رقم الهاتف', 
              subtitle: prefs.getString('phone') ?? 'لا يوجد', 
            ),
            ProfileCard
            (
              title: 'الشركة:', 
              subtitle: prefs.getString('companyName') ?? 'لا يوجد', 
            ),     
            ProfileCard
            (
              title: 'البلد:', 
              subtitle: prefs.getString('country') ?? 'لا يوجد', 
            ),     
            ProfileCard
            (
              title: 'المحافظة:', 
              subtitle: prefs.getString('province') ?? 'لا يوجد', 
            ),      
          ]
        )
      ),
    );
  }
}
