import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:vanshopai/Helper/navigators.dart';
import 'package:vanshopai/View/Auth/Login/login.dart';

import '../../sharedprefsUtils.dart';

class RepUnSubmittedPage extends StatelessWidget 
{
  const RepUnSubmittedPage({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      body: Padding
      (
        padding: const EdgeInsets.all(32),
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            const Spacer(),
            const Text
            (
              'لقد أرسلنا طلب مصادقة للشركة التي قمت باختيارها، يمكنك الوصول إلى حسابك بشكلٍ كامل عندما تتم الموافقة على طلب المصادقة',
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18,),
            ),
            const SizedBox(height: 16,),
            Text('عندما تعلم أن الشركة قد وافقت على طلب المصادقة، قم بإعادة تسجيل الدخول مرة أخرى',
            style: TextStyle(color: Colors.orange[200],),
            textAlign: TextAlign.center,
            ),
            const Spacer(),
            GestureDetector
            (
              onTap: () async
              {
                await FirebaseAuth.instance.signOut();
                prefs.clear();
                navigateRemoveUntil(context, LoginPage());
              },
              child: Row
              (
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: 
                [
                  Text('تسجيل الخروج', style: TextStyle(color: Colors.orange[700]),),
                  const SizedBox(width: 8,),
                  Icon(Iconsax.logout, color: Colors.orange[700],)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}