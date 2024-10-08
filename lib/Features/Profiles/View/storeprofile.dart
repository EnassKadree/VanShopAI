import 'package:flutter/material.dart';
import '../../../Extensions/sharedprefsutils.dart';
import '../../Core/Helper/text.dart';
import 'Components/logutbuttton.dart';
import 'Components/profilecard.dart';


class StoreProfile extends StatelessWidget 
{
  const StoreProfile({super.key});


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
                titleText('الملف الشخصي',fontSize: 32),
                const Spacer(),
                const LogoutButton()
              ],
            ),
            const SizedBox(height: 16),
            ProfileCard
            (
              title: 'البريد الإلكتروني',
              subtitle: prefs.getString('email') ?? 'لا يوجد',
            ),
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
